from datetime import datetime
from dateutil.relativedelta import relativedelta
import os

def calcular_idade(data_nasc):
    hoje = datetime.now()
    idade = hoje.year - data_nasc.year - (
        (hoje.month, hoje.day) < (data_nasc.month, data_nasc.day)
    )
    return idade

def limpar_tela():
    if os.name == 'nt':
        os.system('cls')
    else:
        os.system('clear')
