from models.pacientes import SistemaCadastro
import questionary
import time
import utils.helpers as help
import models.planos as plan

sistema = SistemaCadastro()
sistema.carregar_json()

RESET = "\033[0m"
VERDE = "\033[38;2;32;92;63m"
AMARELO = "\033[38;2;255;206;84m"
ROSA = "\033[38;5;198m"

def main():
    while True:
        help.limpar_tela()

        print(f"""
        \033[38;5;208m  _   _       _        _ \033[38;5;198m ____  _                              
        \033[38;5;208m | \ | |_   _| |_ _ __(_)\033[38;5;198m|  _ \| | __ _ _ __  _ __   ___ _ __ 
        \033[38;5;208m |  \| | | | | __| '__| |\033[38;5;198m| |_) | |/ _` | '_ \| '_ \ / _ \ '__|
        \033[38;5;208m | |\  | |_| | |_| |  | |\033[38;5;198m|  __/| | (_| | | | | | | |  __/ |   
        \033[38;5;208m |_| \_|\__,_|\__|_|  |_|\033[38;5;198m|_|   |_|\__,_|_| |_|_| |_|\___|_| 

     {VERDE}✧{AMARELO}₊⁺{ROSA} Developed by Helena Vieira, Maria Clara Pastor & Camila Ribeiro {VERDE}✧{AMARELO}₊⁺                                                   
        """)

        menu_principal = questionary.select("MENU PRINCIPAL:", choices=["1- Gerenciar pacientes", "2- Gerenciar alimentos", "3- Criar plano nutricional", "4- Sair do programa"], qmark="").ask()
    
        if menu_principal == "1- Gerenciar pacientes":
            while True:
                gerenciar_pacientes = questionary.select("GERENCIAR PACIENTES:", choices=["1- Cadastrar novo paciente", "2- Visualizar paciente", "3- Editar paciente", "4- Deletar paciente", "5- Voltar para o menu principal"], qmark="").ask()
                
                if gerenciar_pacientes == "1- Cadastrar novo paciente":
                    sistema.cadastro_paciente()
                    time.sleep(5)
                    help.limpar_tela()
                
                elif gerenciar_pacientes == "2- Visualizar paciente":
                    sistema.visualizar_paciente()
                    help.limpar_tela()

                elif gerenciar_pacientes == "3- Editar paciente":
                    sistema.editar_paciente()
                    time.sleep(5)
                    help.limpar_tela()

                elif gerenciar_pacientes == "4- Deletar paciente":
                    sistema.deletar_paciente()
                    time.sleep(5)
                    help.limpar_tela()
                
                else:
                    break
        
        elif menu_principal == "2- Gerenciar alimentos":
            print("Em desenvolvimento...")
            time.sleep(3)
        
        elif menu_principal == "3- Criar plano nutricional":
            plan.criar_plano(sistema)
            time.sleep(5)
        
        else:
            print("Salvando informações...")
            time.sleep(3)
            print("Fechando sistema...")
            time.sleep(3)
            exit()


if __name__ == "__main__":
    main()


