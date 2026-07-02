import os
from pathlib import Path
import pandas as pd

from db.conexoes import ConexaoDB

class FonteDadosAlimentos:
    def buscar(self, nome: str):
        raise NotImplementedError

    def todos(self):
        raise NotImplementedError


class TacoMySQL(FonteDadosAlimentos):
    def __init__(self):
        conn = ConexaoDB.get()
        query = """
        SELECT 
            descricao as `Descrição dos alimentos`,
            energia_kcal as `Energia (kcal.)`,
            proteina as `Proteína (g.)`,
            carboidrato as `Carboidrato (g.)`,
            lipideos as `Lipídeos (g.)`,
            fibra_alimentar as `Fibra.Alimentar (g.)`,
            calcio as `Cálcio (mg.)`,
            ferro as `Ferro (mg.)`,
            sodio as `Sódio (mg.)`,
            potassio as `Potássio (mg.)`,
            rae as `RAE (mcg.)`,
            vitamina_c as `Vitamina.C (mg.)`
        FROM alimentos
        """
        self._df = pd.read_sql(query, conn)

    def buscar(self, nome: str):
        return self._df[self._df["Descrição dos alimentos"].str.contains(nome, case=False, na=False)]

    def todos(self):
        return self._df


_fonte = TacoMySQL()
tabela_taco = _fonte.todos()