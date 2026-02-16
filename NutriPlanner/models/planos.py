from models.pacientes import SistemaCadastro
from models import refeiçoes as rf

class PlanoNutricional:
    def __init__(self, refeicoes, totais, observacoes):
        self.refeicoes = refeicoes
        self.totais = totais
        self.observacoes = observacoes
        

def criar_plano(sistema):
    print("-" * 60)
    print("📋 CRIAR PLANO NUTRICIONAL")

    paciente = sistema.selecionar_pacientes()
    if paciente is None:
        return

    sistema.informacoes_principais(paciente)

    refeicoes, totais, obs = rf.buscar_alimento()

    plano = {
        "refeicoes": refeicoes,
        "totais": totais,
        "observacoes": obs
    }

    paciente.plano = plano
    sistema.salvar_json()

    print("✅ Plano nutricional salvo ao paciente com sucesso!")