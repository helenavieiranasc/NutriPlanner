from datetime import datetime
import questionary
import re
import services.calculos as calc
import utils.helpers as help
import json


class Paciente:
    def __init__(self, nome, data_nasc, sexo, gravidez, etnia, profissao, telefone, cpf, email,
                 objetivo, doencas, medicamentos, alergias, intolerancias, 
                 intestino, sono, peso, altura, medida_cintura, metodo_tmb, atividade_fisica, consumo_agua, 
                 alcool, meta_1, meta_2, meta_3):
        self.nome = nome
        self.data_nasc = data_nasc
        self.idade = help.calcular_idade(data_nasc)
        self.sexo = sexo
        self.gravidez = gravidez
        self.etnia = etnia
        self.profissao = profissao
        self.telefone = telefone
        self.cpf = cpf
        self.email = email
        self.objetivo = objetivo
        self.doencas = doencas
        self.medicamentos = medicamentos
        self.alergias = alergias
        self.intolerancias = intolerancias
        self.intestino = intestino
        self.sono = sono
        self.peso = peso
        self.altura = altura
        self.medida_cintura = medida_cintura
        self.metodo_tmb = metodo_tmb
        self.atividade_fisica = atividade_fisica
        self.consumo_agua = consumo_agua
        self.alcool = alcool
        self.meta_1 = meta_1
        self.meta_2 = meta_2
        self.meta_3 = meta_3
        self.plano = None

    def calcular_tudo(self):
        import services.calculos as calc

        self.imc_atual = calc.calculo_imc(self)
        self.classificacao_imc = calc.classificar_imc(self.imc_atual, self)

        self.relacao_ca = calc.calculo_ca(self)
        self.classificacao_ca = calc.classificar_relacao_ca(self.relacao_ca, self)

        self.tmb = calc.calculo_tmb(self)
        self.gasto_total = calc.calculo_gasto_total(self)

        (self.prot_min, self.prot_max,
         self.prot_kcal_min, self.prot_kcal_max) = calc.calcular_proteinas(self)

        (self.gord_min, self.gord_max,
         self.gord_kcal_min, self.gord_kcal_max) = calc.calcular_gorduras(self)

        (self.carb_min, self.carb_max,
         self.carb_kcal_min, self.carb_kcal_max) = calc.calcular_carboidratos(self)

        (self.fibra_min, self.fibra_max) = calc.calcular_fibras(self)

        self.minerais = calc.minerais(self)
        self.vitaminas = calc.vitaminas(self)
        self.acidos_graxos = calc.acidos_graxos(self)

        (self.hidratacao_ml,
         self.hidratacao_litros,
         self.alerta_hidratacao) = calc.calcular_hidratacao(self)

    def to_dict(self):
        return {
            "nome": self.nome,
            "data_nasc": self.data_nasc.strftime("%d/%m/%Y"),
            "sexo": self.sexo,
            "gravidez": self.gravidez,
            "etnia": self.etnia,
            "profissao": self.profissao,
            "telefone": self.telefone,
            "cpf": self.cpf,
            "email": self.email,
            "objetivo": self.objetivo,
            "doencas": self.doencas,
            "medicamentos": self.medicamentos,
            "alergias": self.alergias,
            "intolerancias": self.intolerancias,
            "intestino": self.intestino,
            "sono": self.sono,
            "peso": self.peso,
            "altura": self.altura,
            "medida_cintura": self.medida_cintura,
            "metodo_tmb": self.metodo_tmb,
            "atividade_fisica": self.atividade_fisica,
            "consumo_agua": self.consumo_agua,
            "alcool": self.alcool,
            "meta_1": self.meta_1,
            "meta_2": self.meta_2,
            "meta_3": self.meta_3,

            "imc_atual": self.imc_atual,
            "classificacao_imc": self.classificacao_imc,
            "relacao_ca": self.relacao_ca,
            "classificacao_ca": self.classificacao_ca,
            "tmb": self.tmb,
            "gasto_total": self.gasto_total,

            "prot_min": self.prot_min,
            "prot_max": self.prot_max,
            "prot_kcal_min": self.prot_kcal_min,
            "prot_kcal_max": self.prot_kcal_max,

            "gord_min": self.gord_min,
            "gord_max": self.gord_max,
            "gord_kcal_min": self.gord_kcal_min,
            "gord_kcal_max": self.gord_kcal_max,

            "carb_min": self.carb_min,
            "carb_max": self.carb_max,
            "carb_kcal_min": self.carb_kcal_min,
            "carb_kcal_max": self.carb_kcal_max,

            "fibra_min": self.fibra_min,
            "fibra_max": self.fibra_max,

            "minerais": self.minerais,
            "vitaminas": self.vitaminas,
            "acidos_graxos": self.acidos_graxos,

            "hidratacao_ml": self.hidratacao_ml,
            "hidratacao_litros": self.hidratacao_litros,
            "alerta_hidratacao": self.alerta_hidratacao,
            "plano": self.plano

        }


    @staticmethod
    def from_dict(data):
        data_nasc = datetime.strptime(data["data_nasc"], "%d/%m/%Y")

        p = Paciente(
            data["nome"], data_nasc, data["sexo"], data["gravidez"], data["etnia"],
            data["profissao"], data["telefone"], data["cpf"], data["email"],
            data["objetivo"], data["doencas"], data["medicamentos"],
            data["alergias"], data["intolerancias"], data["intestino"], data["sono"],
            data["peso"], data["altura"], data["medida_cintura"],
            data["metodo_tmb"], data["atividade_fisica"],
            data["consumo_agua"], data["alcool"],
            data["meta_1"], data["meta_2"], data["meta_3"]
        )

        p.imc_atual = data["imc_atual"]
        p.classificacao_imc = data["classificacao_imc"]
        p.relacao_ca = data["relacao_ca"]
        p.classificacao_ca = data["classificacao_ca"]
        p.tmb = data["tmb"]
        p.gasto_total = data["gasto_total"]

        p.prot_min = data["prot_min"]
        p.prot_max = data["prot_max"]
        p.prot_kcal_min = data["prot_kcal_min"]
        p.prot_kcal_max = data["prot_kcal_max"]

        p.gord_min = data["gord_min"]
        p.gord_max = data["gord_max"]
        p.gord_kcal_min = data["gord_kcal_min"]
        p.gord_kcal_max = data["gord_kcal_max"]

        p.carb_min = data["carb_min"]
        p.carb_max = data["carb_max"]
        p.carb_kcal_min = data["carb_kcal_min"]
        p.carb_kcal_max = data["carb_kcal_max"]

        p.fibra_min = data["fibra_min"]
        p.fibra_max = data["fibra_max"]

        p.minerais = data["minerais"]
        p.vitaminas = data["vitaminas"]
        p.acidos_graxos = data["acidos_graxos"]

        p.hidratacao_ml = data["hidratacao_ml"]
        p.hidratacao_litros = data["hidratacao_litros"]
        p.alerta_hidratacao = data["alerta_hidratacao"]
        p.plano = data.get("plano", None)


        return p


class SistemaCadastro:
    def __init__(self):
        self.pacientes = {}
    
    def cadastro_paciente(self):
        # ----------- DADOS PESSOAIS ---------------
        while True:
            nome = input(" Nome: ").strip().title()
            nome_limpo = nome.replace(" ", "")
            if nome_limpo.isalpha():
                break
            else:
                print(" Por favor digite um nome válido! (apenas letras)")
        
        while True:
            data_nasc = input(" Data de nascimento (DD/MM/AAAA): ")
            try:
                data_nasc = datetime.strptime(data_nasc, "%d/%m/%Y")
                break
            except ValueError:
                print(" Por favor digite um data válida!")
        
        sexo = questionary.select("Sexo:", choices =["F", "M"], qmark="").ask()
        if sexo == "F":
            gravidez = questionary.select("Selecione se a paciente está grávida ou amamentando:", choices=["Sim", "Não"], qmark="").ask()
        else:
            gravidez = "Não"
            pass

        etnia = questionary.select("Etnia:", choices=["Branca", "Preta", "Amarela", "Parda", "Indígena"], qmark="").ask()

        while True:
            profissao = input(" Profissão: ").strip().title()
            profissao_limpa = profissao.replace(" ", "")
            if profissao_limpa.isalpha():
                break
            else:
                print(" Por favor digite uma profissão válida! (apenas letras)")
        
        while True:
            telefone = input(" Telefone (apenas números): ").strip()
            if telefone.isdigit() and 8 <= len(telefone) <= 11:
                break
            else:
                print(" Por favor digite um telefone válido! (apenas números)")

        while True:
            cpf = input(" CPF (apenas números): ").strip()
            if cpf.isdigit() and len(cpf) == 11:
                if cpf in self.pacientes:
                    print(" CPF já cadastrado!")
                else:
                    break        
            else:
                print(" Por favor digite um CPF válido! (apenas 11 números)")
                
        while True:
            email = input(" E-mail: ").strip()
            if re.fullmatch(r"[^@]+@[^@]+\.[^@]+", email):
                break
            else:
                print(" E-mail inválido, tente novamente!")

        # ------------- OBJETIVO -----------------
        objetivo = questionary.select("Objetivo principal: ", choices=["Emagrecimento", "Manutenção", "Hipertrofia (ganho de massa)"], qmark="").ask()

        # ------------ HISTÓRICO DE SAÚDE ------------
        print(" Doenças diagnosticadas: ")
        doencas = []
        i = 1
        while True:
            entrada = input(f" {i}- ")
            if entrada == "":
                if len(doencas) == 0:
                    doencas.append("Não se aplica")
                break
            else:
                doencas.append(entrada.capitalize())
                i += 1

        print(" Medicamentos continuos: ")
        medicamentos = []
        i = 1
        while True:
            entrada = input(f" {i}- ")
            if entrada == "":
                if len(medicamentos) == 0:
                    medicamentos.append("Não se aplica")
                break
            else:
                medicamentos.append(entrada.capitalize())
                i += 1
                
        print("  Alergias: ")
        alergias = []
        i = 1
        while True:
            entrada = input(f" {i}- ")
            if entrada == "":
                if len(alergias) == 0:
                    alergias.append("Não se aplica")
                break
            else:
                alergias.append(entrada.capitalize())
                i += 1
        
        print("  Intolerâncias: ")
        intolerancias = []
        i = 1
        while True:
            entrada = input(f" {i}- ")
            if entrada == "":
                if len(intolerancias) == 0:
                    intolerancias.append("Não se aplica")
                break
            else:
                intolerancias.append(entrada.capitalize())
                i += 1

        intestino = questionary.select("Frequência intestinal: ", choices=[
            "1x ao dia (normal)",
            "2x ao dia",
            "A cada 2 dias",
            "A cada 3 dias",
            "A cada 4–5 dias",
            "Menos de 1x por semana"], qmark="").ask()
        
        sono = questionary.select("Qualidade do sono: ", choices=[
            "Excelente (sono reparador)",
            "Bom (dorme bem na maioria dos dias)",
            "Regular (acorda algumas vezes, sono leve)",
            "Ruim (dificuldade para dormir ou manter o sono)",
            "Insônia (demora para dormir ou acorda muitas vezes)"], qmark="").ask()
        
        # ------------ AVALIAÇÃO ANTROPOMÉTRICA ------------
        while True:
            try:
                peso = float(input(" Peso (Kg): "))
                if peso > 0:
                    break
                else:
                    print(" Peso inválido, tente novamente!")
            except ValueError:
                print(" Peso inválido, tente novamente!")
        
        while True:
            try:
                altura = float(input(" Altura (cm): "))
                if 0 < altura < 300:
                    break
                else:
                    print(" Altura inválida, tente novamente!")
            except ValueError:
                print(" Altura inválida, tente novamente!")

        while True:
            try:
                medida_cintura = float(input(" Circunferência da cintura (cm): "))
                if medida_cintura > 0:
                    break
                else:
                    print(" Medida inválida, tente novamente!")
            except ValueError:
                print(" Medida inválida, tente novamente!")

        metodo_tmb = questionary.select("Método de cálculo de taxa metabólica basal que será utilizado:", choices=["Harris-Benedict (padrão geral)",
        "Mifflin-St Jeor (pacientes com sobrepeso/obesidade)"], qmark="").ask()

        # ---------- HÁBITOS E ESTILO DE VIDA -----------
        atividade_fisica = questionary.select("Nível de atividade física: ", choices=[
            "Sedentário (não pratica exercícios)",
            "Leve (1–2x por semana)",
            "Moderado (3–4x por semana)",
            "Intenso (5–6x por semana)",
            "Atleta/treino diário",
            "Trabalho fisicamente ativo (ex.: estoquista, operário)"], qmark="").ask()
        
        consumo_agua = questionary.select("Consumo diário de água: ", choices=[
            "Menos de 500 ml/dia",
            "Entre 500 ml e 1 L/dia",
            "Entre 1 L e 1,5 L/dia",
            "Entre 1,5 L e 2 L/dia",
            "Entre 2 L e 3 L/dia",
            "Mais de 3 L/dia"], qmark="").ask()
        
        alcool = questionary.select("Frequência de consumo de bebida alcoólica: ", choices=[
            "Não consome",
            "Raramente (1x/mês ou menos)",
            "Socialmente (2–4x/mês)",
            "1x por semana",
            "2–3x por semana",
            "4–5x por semana",
            "Diariamente",
            "Ex-consumidor"], qmark="").ask()

        # ------------ METAS INICIAIS -------------
        while True: 
            meta_1 = input(" Meta 1: ").strip().capitalize()
            if meta_1 == "":
                print(" Por favor digite um meta válida!")
            else:
                break
        
        meta_2 = input(" Meta 2: ").strip().capitalize()
        if meta_2 == "":
            meta_2 = "Não se aplica"
        
        meta_3 = input(" Meta 3: ").strip().capitalize()
        if meta_3 == "":
            meta_3 = "Não se aplica"

        paciente = Paciente(nome, data_nasc, sexo, gravidez, etnia, profissao, telefone, cpf, email,
                           objetivo, doencas, medicamentos, alergias, intolerancias,
                           intestino, sono, peso, altura, medida_cintura, metodo_tmb, 
                           atividade_fisica, consumo_agua, alcool, meta_1, meta_2, meta_3)
        

        paciente.imc_atual = calc.calculo_imc(paciente)
        paciente.classificacao_imc = calc.classificar_imc(paciente.imc_atual, paciente)
        paciente.relacao_ca = calc.calculo_ca(paciente)
        paciente.classificacao_ca = calc.classificar_relacao_ca(paciente.relacao_ca, paciente)
        paciente.tmb = calc.calculo_tmb(paciente)
        paciente.gasto_total = calc.calculo_gasto_total(paciente)
        (paciente.prot_min, paciente.prot_max, paciente.prot_kcal_min, paciente.prot_kcal_max) = calc.calcular_proteinas(paciente)
        (paciente.gord_min, paciente.gord_max, paciente.gord_kcal_min, paciente.gord_kcal_max) = calc.calcular_gorduras(paciente)
        (paciente.carb_min, paciente.carb_max, paciente.carb_kcal_min, paciente.carb_kcal_max) = calc.calcular_carboidratos(paciente)
        (paciente.fibra_min, paciente.fibra_max) = calc.calcular_fibras(paciente)
        paciente.minerais = calc.minerais(paciente)
        paciente.vitaminas = calc.vitaminas(paciente)
        paciente.acidos_graxos = calc.acidos_graxos(paciente)
        (paciente.hidratacao_ml, paciente.hidratacao_litros, paciente.alerta_hidratacao) = calc.calcular_hidratacao(paciente)



        self.pacientes[cpf] = paciente
        print("\nPaciente cadastrado com sucesso!")
        self.salvar_json()
        return paciente
    

    def salvar_json(self):
        dados = {cpf: paciente.to_dict() for cpf, paciente in self.pacientes.items()}

        with open("pacientes.json", "w", encoding="utf-8") as f:
            json.dump(dados, f, indent=4, ensure_ascii=False)

        print("📁 Dados salvos em pacientes.json!")


    def carregar_json(self):
        try:
            with open("pacientes.json", "r", encoding="utf-8") as f:
                dados = json.load(f)

            for cpf, info in dados.items():
                paciente = Paciente.from_dict(info)
                self.pacientes[cpf] = paciente

            print("📂 Pacientes carregados com sucesso!")
        except FileNotFoundError:
            print("⚠️ Nenhum arquivo encontrado, iniciando vazio")


    def selecionar_pacientes(self):
        if len(self.pacientes) == 0:
            print("Nenhum paciente cadastrado!")
            return
        
        nomes_pacientes = []
        for _, paciente in self.pacientes.items():
            nomes_pacientes.append(paciente.nome)

        paciente_selecionado = questionary.select("Selecione o paciente: ",
         choices=nomes_pacientes, qmark="").ask()
        
        for _, paciente in self.pacientes.items():
            if paciente.nome == paciente_selecionado:
                paciente_selecionado = paciente
                return paciente
        return None



    def visualizar_paciente(self):
        paciente_selecionado = self.selecionar_pacientes()
        if paciente_selecionado == None:
            return
        
        print("\n" + "="*60)
        print(f"{'FICHA DO PACIENTE':^60}")
        print("="*60)

        print("\n📋 DADOS PESSOAIS")
        print("-" * 60)
        print(f"  Nome: {paciente_selecionado.nome}")
        print(f"  Data de Nascimento: {paciente_selecionado.data_nasc.strftime('%d/%m/%Y')}")
        print(f"  Sexo: {paciente_selecionado.sexo}")
        if paciente_selecionado.sexo == "F":
            print(f"  Grávida ou amamentando: {paciente_selecionado.gravidez}")
        print(f"  Etnia: {paciente_selecionado.etnia}")
        print(f"  Profissão: {paciente_selecionado.profissao}")
        print(f"  CPF: {paciente_selecionado.cpf}")
        print(f"  Telefone: {paciente_selecionado.telefone}")
        print(f"  E-mail: {paciente_selecionado.email}")

        print("\n🎯 OBJETIVO PRINCIPAL")
        print("-" * 60)
        print(f"  {paciente_selecionado.objetivo}")

        print("\n🏥 HISTÓRICO DE SAÚDE")
        print("-" * 60)

        print("  Doenças Diagnosticadas:")
        for doenca in paciente_selecionado.doencas:
            print(f"    • {doenca}")

        print("\n  Medicamentos Contínuos:")
        for medicamento in paciente_selecionado.medicamentos:
            print(f"    • {medicamento}")

        print("\n  Alergias:")
        for alergia in paciente_selecionado.alergias:
            print(f"    • {alergia}")

        print("\n  Intolerâncias:")
        for intolerancia in paciente_selecionado.intolerancias:
            print(f"    • {intolerancia}")

        print(f"\n  Frequência Intestinal: {paciente_selecionado.intestino}")
        print(f"  Qualidade do Sono: {paciente_selecionado.sono}")

        print("\n📏 AVALIAÇÃO ANTROPOMÉTRICA")
        print("-" * 60)
        print(f"  Peso: {paciente_selecionado.peso} kg")
        print(f"  Altura: {paciente_selecionado.altura} cm")
        print(f"  Circunferência da cintura: {paciente_selecionado.medida_cintura} cm")

        print("\n💪 HÁBITOS E ESTILO DE VIDA")
        print("-" * 60)
        print(f"  Atividade Física: {paciente_selecionado.atividade_fisica}")
        print(f"  Consumo de Água: {paciente_selecionado.consumo_agua}")
        print(f"  Consumo de Álcool: {paciente_selecionado.alcool}")

        print("\n🎖️  METAS INICIAIS")
        print("-" * 60)
        print(f"  1. {paciente_selecionado.meta_1}")
        print(f"  2. {paciente_selecionado.meta_2}")
        print(f"  3. {paciente_selecionado.meta_3}")

        print("\n 📊 CÁLCULOS")
        print("-" * 60)
        print(f" IMC atual: {paciente_selecionado.imc_atual:.2f} -> {paciente_selecionado.classificacao_imc}")
        print(f" Relação cintura-altura: {paciente_selecionado.relacao_ca:.2f} -> {paciente_selecionado.classificacao_ca}")
        print(f" TMB: {paciente_selecionado.tmb:.2f} kcal/dia")
        print(f" Gasto calórico total: {paciente_selecionado.gasto_total:.2f} kcal/dia")
        print("-" * 60)     

        print("\n 📈 MACRONUTRIENTES (Faixas Diárias)")
        print("-" * 60)

        print(f"\n 🥩 Proteínas:  min. {paciente_selecionado.prot_min:.0f}g  –  max. {paciente_selecionado.prot_max:.0f}g/dia   "f"[{(paciente_selecionado.prot_min/paciente_selecionado.peso):.1f}–{(paciente_selecionado.prot_max/paciente_selecionado.peso):.1f} g/kg]")
        print(f"            ({paciente_selecionado.prot_kcal_min:.0f}–{paciente_selecionado.prot_kcal_max:.0f} kcal)   "f"{(paciente_selecionado.prot_kcal_min/paciente_selecionado.gasto_total)*100:.0f}%–{(paciente_selecionado.prot_kcal_max/paciente_selecionado.gasto_total)*100:.0f}%")


        print(f"\n 🍚 Carboidratos:  min. {paciente_selecionado.carb_min:.0f}g  –  max. {paciente_selecionado.carb_max:.0f}g/dia")
        print(f"            ({paciente_selecionado.carb_kcal_min:.0f}–{paciente_selecionado.carb_kcal_max:.0f} kcal)   "f"{(paciente_selecionado.carb_kcal_min/paciente_selecionado.gasto_total)*100:.0f}%–{(paciente_selecionado.carb_kcal_max/paciente_selecionado.gasto_total)*100:.0f}%")


        print(f"\n 🧈 Gorduras:  min. {paciente_selecionado.gord_min:.0f}g  –  max. {paciente_selecionado.gord_max:.0f}g/dia   "f"[{(paciente_selecionado.gord_min/paciente_selecionado.peso):.1f}–{(paciente_selecionado.gord_max/paciente_selecionado.peso):.1f} g/kg]")
        print(f"           ({paciente_selecionado.gord_kcal_min:.0f}–{paciente_selecionado.gord_kcal_max:.0f} kcal)   "f"{(paciente_selecionado.gord_kcal_min/paciente_selecionado.gasto_total)*100:.0f}%–{(paciente_selecionado.gord_kcal_max/paciente_selecionado.gasto_total)*100:.0f}%")


        print(f"\n 🍎 Fibras:  min. {paciente_selecionado.fibra_min:.0f}g  –  max. {paciente_selecionado.fibra_max:.0f}g/dia")
        print("-" * 60)

        print("-" * 60)
        print("\n 📉 MICRONUTRIENTES (Faixas Diárias)")
        print("-" * 60)
        print("\n🧂 MINERAIS (Recomendações Diárias)")
        print("-" * 60)
        for nome, (minimo, maximo) in paciente_selecionado.minerais.items():
            if maximo is None:
                print(f" {nome.capitalize()}: {minimo} (sem limite máximo definido)")
            else:
                print(f" {nome.capitalize()}: {minimo} – {maximo}")

        print("\n🍊 VITAMINAS (Recomendações Diárias)")
        print("-" * 60)
        for nome, (minimo, maximo) in paciente_selecionado.vitaminas.items():
            if maximo is None:
                print(f" {nome.capitalize()}: {minimo} (sem limite máximo definido)")
            else:
                print(f" {nome.capitalize()}: {minimo} – {maximo}")

        print("\n🥑 ÁCIDOS GRAXOS ESSENCIAIS")
        print("-" * 60)
        for nome, (minimo, maximo) in paciente_selecionado.acidos_graxos.items():
            if maximo is None:
                print(f" {nome.replace('_', ' ').capitalize()}: {minimo} (sem limite máximo definido)")
            else:
                print(f" {nome.replace('_', ' ').capitalize()}: {minimo} – {maximo}")
        print("-" * 60)

        print("\n💧 HIDRATAÇÃO RECOMENDADA")
        print("-" * 60)
        print(f" Ingestão recomendada: {paciente_selecionado.hidratacao_ml} mL/dia")
        print(f" Equivalente a: {paciente_selecionado.hidratacao_litros} litros/dia")
        print(f" {paciente_selecionado.alerta_hidratacao}")

        print("\n" + "="*60 + "\n")
        input("\nPressione ENTER para visualizar o plano nutricional do paciente")
        help.limpar_tela()

        print("\n" + "-"*60)
        print("📋 PLANO NUTRICIONAL")
        print("-" * 60)


        if not paciente_selecionado.plano:
            print("❌ Nenhum plano nutricional cadastrado ainda!")
            return     
        else:
            plano = paciente_selecionado.plano

        print("\n🍽️ REFEIÇÕES:")
        for refeicao, itens in plano["refeicoes"].items():
            print("-" * 60)
            print(refeicao)
            if not itens:
                print("   Nenhum alimento cadastrado nessa refeição!")
            else:
                for item in itens:
                    alimento = item["alimento"]
                    qtd = item["quantidade"]
                    medida = item["medida"]
                    kcal = item["calorias"]

                    if medida == "Á vontade":
                        print(f" - {medida} de {alimento} ({kcal:.1f} kcal)")
                    else:
                        print(f" - {qtd} {medida} de {alimento} ({kcal:.1f} kcal)")

        print("\n📊 TOTAIS DO PLANO:")
        totais = plano["totais"]

        print(f" 🔥 Calorias: {totais['calorias']:.1f} kcal")
        print(f" 🥩 Proteínas: {totais['proteina']:.1f} g")
        print(f" 🍚 Carboidratos: {totais['carboidrato']:.1f} g")
        print(f" 🧈 Gorduras: {totais['lipideos']:.1f} g")
        print(f" 🍎 Fibras: {totais['fibra']:.1f} g")
        print(f"\n 🧂 Cálcio: {totais['calcio']:.1f} mg")
        print(f" 🧂 Ferro: {totais['ferro']:.1f} mg")
        print(f" 🧂 Sódio: {totais['sodio']:.1f} mg")
        print(f" 🧂 Potássio: {totais['potassio']:.1f} mg")
        print(f"\n 🍊 Vitamina A: {totais['vitamina_a']:.1f} mcg")
        print(f" 🍊 Vitamina C: {totais['vitamina_c']:.1f} mg")

        if plano.get("observacoes"):
            print("\n‼️ OBSERVAÇÕES:")
            print(plano["observacoes"])
            print(" ")
        else:
            print("\n‼️ OBSERVAÇÕES:")
            print("Não foi adicionada nenhuma observação!\n")
        
        input("\nPressione ENTER para voltar ao menu gerenciar pacientes...")




    def informacoes_principais(self, paciente_selecionado):
        if paciente_selecionado == None:
            return
        
        print("-" * 60)
        print("PRINCIPAIS INFORMAÇÕES DO PACIENTE")
        print("-" * 60)
        
        print(f"  Nome: {paciente_selecionado.nome}")
        if paciente_selecionado.sexo == "F" and paciente_selecionado.gravidez == "Sim":
            print(f" Grávida ou amamentando: {paciente_selecionado.gravidez}")
        print(f"  {paciente_selecionado.objetivo}")
        
        print(f"\n IMC atual: {paciente_selecionado.imc_atual:.2f} -> {paciente_selecionado.classificacao_imc}")
        print(f" Relação cintura-altura: {paciente_selecionado.relacao_ca:.2f} -> {paciente_selecionado.classificacao_ca}")
        print(f" TMB: {paciente_selecionado.tmb:.2f} kcal/dia")
        print(f" Gasto calórico total: {paciente_selecionado.gasto_total:.2f} kcal/dia")
            

        print("\n 📈 MACRONUTRIENTES (Faixas Diárias)")
        print("-" * 60)

        print(f"\n 🥩 Proteínas:  min. {paciente_selecionado.prot_min:.0f}g  –  max. {paciente_selecionado.prot_max:.0f}g/dia   "f"[{(paciente_selecionado.prot_min/paciente_selecionado.peso):.1f}–{(paciente_selecionado.prot_max/paciente_selecionado.peso):.1f} g/kg]")
        print(f"            ({paciente_selecionado.prot_kcal_min:.0f}–{paciente_selecionado.prot_kcal_max:.0f} kcal)   "f"{(paciente_selecionado.prot_kcal_min/paciente_selecionado.gasto_total)*100:.0f}%–{(paciente_selecionado.prot_kcal_max/paciente_selecionado.gasto_total)*100:.0f}%")


        print(f"\n 🍚 Carboidratos:  min. {paciente_selecionado.carb_min:.0f}g  –  max. {paciente_selecionado.carb_max:.0f}g/dia")
        print(f"            ({paciente_selecionado.carb_kcal_min:.0f}–{paciente_selecionado.carb_kcal_max:.0f} kcal)   "f"{(paciente_selecionado.carb_kcal_min/paciente_selecionado.gasto_total)*100:.0f}%–{(paciente_selecionado.carb_kcal_max/paciente_selecionado.gasto_total)*100:.0f}%")


        print(f"\n 🧈 Gorduras:  min. {paciente_selecionado.gord_min:.0f}g  –  max. {paciente_selecionado.gord_max:.0f}g/dia   "f"[{(paciente_selecionado.gord_min/paciente_selecionado.peso):.1f}–{(paciente_selecionado.gord_max/paciente_selecionado.peso):.1f} g/kg]")
        print(f"           ({paciente_selecionado.gord_kcal_min:.0f}–{paciente_selecionado.gord_kcal_max:.0f} kcal)   "f"{(paciente_selecionado.gord_kcal_min/paciente_selecionado.gasto_total)*100:.0f}%–{(paciente_selecionado.gord_kcal_max/paciente_selecionado.gasto_total)*100:.0f}%")


        print(f"\n 🍎 Fibras:  min. {paciente_selecionado.fibra_min:.0f}g  –  max. {paciente_selecionado.fibra_max:.0f}g/dia")
        print("-" * 60)

        print("-" * 60)
        print("\n 📉 MICRONUTRIENTES (Faixas Diárias)")
        print("-" * 60)
        print("\n🧂 MINERAIS (Recomendações Diárias)")
        print("-" * 60)
        for nome, (minimo, maximo) in paciente_selecionado.minerais.items():
            if maximo is None:
                print(f" {nome.capitalize()}: {minimo} (sem limite máximo definido)")
            else:
                print(f" {nome.capitalize()}: {minimo} – {maximo}")

        print("\n🍊 VITAMINAS (Recomendações Diárias)")
        print("-" * 60)
        for nome, (minimo, maximo) in paciente_selecionado.vitaminas.items():
            if maximo is None:
                print(f" {nome.capitalize()}: {minimo} (sem limite máximo definido)")
            else:
                print(f" {nome.capitalize()}: {minimo} – {maximo}")

        print("\n🥑 ÁCIDOS GRAXOS ESSENCIAIS")
        print("-" * 60)
        for nome, (minimo, maximo) in paciente_selecionado.acidos_graxos.items():
            if maximo is None:
                print(f" {nome.replace('_', ' ').capitalize()}: {minimo} (sem limite máximo definido)")
            else:
                print(f" {nome.replace('_', ' ').capitalize()}: {minimo} – {maximo}")
        print("-" * 60)

        print(" 🚨 RESTRIÇÕES: ")
        print("  Doenças Diagnosticadas:")
        for doenca in paciente_selecionado.doencas:
            print(f"    • {doenca}")

        print("\n  Medicamentos Contínuos:")
        for medicamento in paciente_selecionado.medicamentos:
            print(f"    • {medicamento}")

        print("\n  Alergias:")
        for alergia in paciente_selecionado.alergias:
            print(f"    • {alergia}")

        print("\n  Intolerâncias:")
        for intolerancia in paciente_selecionado.intolerancias:
            print(f"    • {intolerancia}")


    def editar_paciente(self):
        print("-" * 60)
        print("✏️ EDITAR PACIENTE")
        print("-" * 60)

        paciente = self.selecionar_pacientes()
        if paciente is None:
            return

        while True:
            escolha = questionary.select(
                "O que deseja editar?",
                choices=[
                    "Nome",
                    "Data de nascimento",
                    "Sexo / Gravidez",
                    "Etnia",
                    "Profissão",
                    "Telefone",
                    "CPF",
                    "Email",
                    "Objetivo",
                    "Doenças",
                    "Medicamentos",
                    "Alergias",
                    "Intolerâncias",
                    "Frequência intestinal",
                    "Sono",
                    "Peso",
                    "Altura",
                    "Circunferência da cintura",
                    "Método TMB",
                    "Atividade física",
                    "Consumo de água",
                    "Álcool",
                    "Metas",
                    "Remover plano nutricional",
                    "Sair e salvar"
                ],
                qmark=""
            ).ask()


            if escolha == "Nome":
                while True:
                    nome = input(" Novo nome: ").strip().title()
                    if nome.replace(" ", "").isalpha():
                        paciente.nome = nome
                        break
                    print(" Nome inválido! Apenas letras.")

            elif escolha == "Data de nascimento":
                while True:
                    dn = input(" Nova data (DD/MM/AAAA): ")
                    try:
                        paciente.data_nasc = datetime.strptime(dn, "%d/%m/%Y")
                        paciente.idade = help.calcular_idade(paciente.data_nasc)
                        break
                    except ValueError:
                        print(" Data inválida!")

            elif escolha == "Sexo / Gravidez":
                sexo = questionary.select("Sexo:", choices=["F", "M"], qmark="").ask()
                paciente.sexo = sexo
                if sexo == "F":
                    paciente.gravidez = questionary.select(
                        "Está grávida ou amamentando?",
                        choices=["Sim", "Não"],
                        qmark=""
                    ).ask()
                else:
                    paciente.gravidez = "Não"

            elif escolha == "Etnia":
                paciente.etnia = questionary.select(
                    "Etnia:", 
                    choices=["Branca", "Preta", "Amarela", "Parda", "Indígena"], 
                    qmark=""
                ).ask()

            elif escolha == "Profissão":
                while True:
                    prof = input(" Nova profissão: ").strip().title()
                    if prof.replace(" ", "").isalpha():
                        paciente.profissao = prof
                        break
                    print(" Profissão inválida!")

            elif escolha == "Telefone":
                while True:
                    tel = input(" Novo telefone (apenas números): ").strip()
                    if tel.isdigit() and 8 <= len(tel) <= 11:
                        paciente.telefone = tel
                        break
                    print(" Telefone inválido!")

            elif escolha == "CPF":
                print(f"CPF atual: {paciente.cpf}")

                while True:
                    novo_cpf = input(" Novo CPF (apenas números) ou Enter para manter: ").strip()

                    if novo_cpf == "":
                        print("✔ CPF mantido.")
                        break

                    if not novo_cpf.isdigit() or len(novo_cpf) != 11:
                        print(" Por favor digite um CPF válido! (apenas 11 números)")
                        continue

                    if novo_cpf in self.pacientes:
                        print(" Já existe um paciente cadastrado com esse CPF!")
                        continue

                    cpf_antigo = paciente.cpf
                    paciente.cpf = novo_cpf

                    self.pacientes[novo_cpf] = self.pacientes.pop(cpf_antigo)

                    print("✔ CPF atualizado com sucesso!")
                    break


            elif escolha == "Email":
                while True:
                    email = input(" Novo email: ").strip()
                    if re.fullmatch(r"[^@]+@[^@]+\.[^@]+", email):
                        paciente.email = email
                        break
                    print(" Email inválido!")


            elif escolha == "Doenças":
                print(" Doenças atuais:")
                for d in paciente.doencas:
                    print(f"  - {d}")
                print("\nDigite novamente a lista (ENTER para finalizar)")
                nova = []
                i = 1
                while True:
                    x = input(f" {i}- ")
                    if x == "":
                        if not nova:
                            nova.append("Não se aplica")
                        break
                    nova.append(x.capitalize())
                    i += 1
                paciente.doencas = nova

            elif escolha == "Medicamentos":
                print(" Medicamentos atuais:")
                for d in paciente.medicamentos:
                    print(f"  - {d}")
                print("\nDigite novamente a lista (ENTER para finalizar)")
                nova = []
                i = 1
                while True:
                    x = input(f" {i}- ")
                    if x == "":
                        if not nova:
                            nova.append("Não se aplica")
                        break
                    nova.append(x.capitalize())
                    i += 1
                paciente.medicamentos = nova

            elif escolha == "Alergias":
                print(" Alergias atuais:")
                for d in paciente.alergias:
                    print(f"  - {d}")
                print("\nDigite novamente a lista (ENTER para finalizar)")
                nova = []
                i = 1
                while True:
                    x = input(f" {i}- ")
                    if x == "":
                        if not nova:
                            nova.append("Não se aplica")
                        break
                    nova.append(x.capitalize())
                    i += 1
                paciente.alergias = nova

            elif escolha == "Intolerâncias":
                print(" Intolerâncias atuais:")
                for d in paciente.intolerancias:
                    print(f"  - {d}")
                print("\nDigite novamente a lista")
                nova = []
                i = 1
                while True:
                    x = input(f" {i}- ")
                    if x == "":
                        if not nova:
                            nova.append("Não se aplica")
                        break
                    nova.append(x.capitalize())
                    i += 1
                paciente.intolerancias = nova


            elif escolha == "Frequência intestinal":
                paciente.intestino = questionary.select(
                    "Frequência intestinal:",
                    choices=[
                        "1x ao dia (normal)",
                        "2x ao dia",
                        "A cada 2 dias",
                        "A cada 3 dias",
                        "A cada 4–5 dias",
                        "Menos de 1x por semana"
                    ],
                    qmark=""
                ).ask()

            elif escolha == "Sono":
                paciente.sono = questionary.select(
                    "Qualidade do sono:",
                    choices=[
                        "Excelente (sono reparador)",
                        "Bom (dorme bem na maioria dos dias)",
                        "Regular (acorda algumas vezes, sono leve)",
                        "Ruim (dificuldade para dormir ou manter o sono)",
                        "Insônia (demora para dormir ou acorda muitas vezes)"
                    ],
                    qmark=""
                ).ask()

            elif escolha == "Peso":
                while True:
                    try:
                        peso = float(input(" Novo peso (kg): "))
                        if peso > 0:
                            paciente.peso = peso
                            break
                    except:
                        pass
                    print(" Peso inválido!")

            elif escolha == "Altura":
                while True:
                    try:
                        alt = float(input(" Nova altura (cm): "))
                        if 0 < alt < 300:
                            paciente.altura = alt
                            break
                    except:
                        pass
                    print(" Altura inválida!")

            elif escolha == "Circunferência da cintura":
                while True:
                    try:
                        cint = float(input(" Nova medida (cm): "))
                        if cint > 0:
                            paciente.medida_cintura = cint
                            break
                    except:
                        pass
                    print(" Medida inválida!")

            elif escolha == "Método TMB":
                paciente.metodo_tmb = questionary.select(
                    "Método TMB:",
                    choices=[
                        "Harris-Benedict (padrão geral)",
                        "Mifflin-St Jeor (pacientes com sobrepeso/obesidade)"
                    ],
                    qmark=""
                ).ask()

            elif escolha == "Atividade física":
                paciente.atividade_fisica = questionary.select(
                    "Atividade física:",
                    choices=[
                        "Sedentário (não pratica exercícios)",
                        "Leve (1–2x por semana)",
                        "Moderado (3–4x por semana)",
                        "Intenso (5–6x por semana)",
                        "Atleta/treino diário",
                        "Trabalho fisicamente ativo (ex.: estoquista, operário)"
                    ],
                    qmark=""
                ).ask()

            elif escolha == "Consumo de água":
                paciente.consumo_agua = questionary.select(
                    "Consumo diário:",
                    choices=[
                        "Menos de 500 ml/dia",
                        "Entre 500 ml e 1 L/dia",
                        "Entre 1 L e 1,5 L/dia",
                        "Entre 1,5 L e 2 L/dia",
                        "Entre 2 L e 3 L/dia",
                        "Mais de 3 L/dia"
                    ],
                    qmark=""
                ).ask()

            elif escolha == "Álcool":
                paciente.alcool = questionary.select(
                    "Consumo de álcool:",
                    choices=[
                        "Não consome",
                        "Raramente (1x/mês ou menos)",
                        "Socialmente (2–4x/mês)",
                        "1x por semana",
                        "2–3x por semana",
                        "4–5x por semana",
                        "Diariamente",
                        "Ex-consumidor"
                    ],
                    qmark=""
                ).ask()


            elif escolha == "Metas":
                while True:
                    meta_1 = input(" Meta 1: ").strip().capitalize()
                    if meta_1 != "":
                        break
                    print(" Meta obrigatória!")
                paciente.meta_1 = meta_1

                meta_2 = input(" Meta 2: ").strip().capitalize()
                paciente.meta_2 = meta_2 if meta_2 else "Não se aplica"

                meta_3 = input(" Meta 3: ").strip().capitalize()
                paciente.meta_3 = meta_3 if meta_3 else "Não se aplica"


            elif escolha == "Remover plano nutricional":
                sim_nao = questionary.select("Tem certeza?", choices=["Sim", "Não"], qmark="❗").ask()
                if sim_nao == "Sim":
                    paciente.plano = None
                    print("Plano removido!")
                else:
                    continue


            elif escolha == "Sair e salvar":
                break

        paciente.calcular_tudo()

        self.salvar_json()

        print("\n✅ Paciente atualizado com sucesso!\n")


    def deletar_paciente(self):
        print("-" * 60)
        print("🗑️ DELETAR PACIENTE")
        print("-" * 60)

        paciente = self.selecionar_pacientes()
        if paciente is None:
            return

        confirmar = questionary.select(f"Tem certeza que deseja DELETAR o paciente '{paciente.nome}'?", choices=["Sim", "Não"], qmark= "‼️").ask()

        if confirmar == "Sim":
        
            cpf_para_remover = None
            for cpf, obj in self.pacientes.items():
                if obj is paciente:
                    cpf_para_remover = cpf
                    break

            if cpf_para_remover:
                del self.pacientes[cpf_para_remover]
                self.salvar_json()
                print("✅ Paciente deletado com sucesso!")
            else:
                print("❌ Erro: paciente não encontrado!")

        else:
            print("❌ Exclusão cancelada!")




