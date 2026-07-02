import services.alimentos as taco
import utils.helpers as help
import questionary
import time

def escolher_medidas(refeicao_atual, escolha, totais_nutricionais, refeicoes_completas):
    conversoes = {
        "Grama(s) (g)": 1,
        "Porção(ões) (100g)": 100,
        "Colher(es) de sopa": 12,
        "Colher(es) de chá": 4,
        "Xícara(s)": 120,
        "Unidade(s)": 80,
        "Fatia(s)": 30,
        "À vontade": None,
    }
    alimento_data = taco.tabela_taco[taco.tabela_taco["Descrição dos alimentos"] == escolha].iloc[0]
    
    medidas = ["Grama(s) (g)", "Colher(es) de sopa", "Colher(es) de chá", "Xícara(s)", "Unidade(s)", "Fatia(s)", "Porção(ões) (100g)", "À vontade"]
    
    def_medida = questionary.select(f"Selecione a medida de {escolha}", choices=medidas, qmark="").ask()

    while True:
        try:
            if def_medida == "À vontade":
                qtd_medida = None
                fator = 0
                print(f"\n{escolha} adicionado ao plano à vontade!")
                break

            else:
                qtd_medida = float(input(f"\n Digite a quantidade de {def_medida}: "))
                if qtd_medida <= 0:
                    print(" Medida inválida! Tente novamente")
                else:
                    print(f"\n{ qtd_medida} {def_medida} de {escolha} adicionadas ao plano!")
                    fator = qtd_medida * conversoes[def_medida]
                    break
        
        except ValueError:
            print(" Por favor, digite um número válido!")
                        
    def somar_nutriente(coluna):
        valor = alimento_data[coluna]
        if valor != "-":
            try:
                return (float(valor) * fator) / 100
            except:
                return 0
        return 0
                    

    item = {
    "alimento": escolha,
    "medida": def_medida,
    "quantidade": qtd_medida,
    "calorias": somar_nutriente("Energia (kcal.)"),
    "proteina": somar_nutriente("Proteína (g.)"),
    "carboidrato": somar_nutriente("Carboidrato (g.)"),
    "lipideos": somar_nutriente("Lipídeos (g.)"),
    "fibra": somar_nutriente("Fibra.Alimentar (g.)"),
    "calcio": somar_nutriente("Cálcio (mg.)"),
    "ferro": somar_nutriente("Ferro (mg.)"),
    "sodio": somar_nutriente("Sódio (mg.)"),
    "potassio": somar_nutriente("Potássio (mg.)"),
    "vitamina_a": somar_nutriente("RAE (mcg.)"),
    "vitamina_c": somar_nutriente("Vitamina.C (mg.)")}

    for nutriente in totais_nutricionais:
        totais_nutricionais[nutriente] += item[nutriente]


    refeicoes_completas.setdefault(refeicao_atual, []).append(item)

refeicoes = ["☕ CAFÉ DA MANHÃ ", "🥪 LANCHE DA MANHÃ", "🍽️ ALMOÇO", "🍉 LANCHE DA TARDE", "🍝 JANTAR", "🥛 CEIA"]

oq_fazer = ["Pesquisar alimentos", "Ir para próxima refeição"]

def buscar_alimento():
    totais_nutricionais = {
            "calorias": 0,
            "proteina": 0,
            "carboidrato": 0,
            "lipideos": 0,
            "fibra": 0,
            "calcio": 0,
            "ferro": 0,
            "sodio": 0,
            "potassio": 0,
            "vitamina_a": 0,
            "vitamina_c": 0}
    
    refeicoes_completas = {r.strip(): [] for r in refeicoes}
    observacoes = ""

    for i in refeicoes:
        print("-" * 60)
        print(i)
        print("-" * 60)

        while True:
            continua_acaba = questionary.select("\nSelecione o que deseja fazer:", choices=oq_fazer, qmark="").ask()

            if continua_acaba == "Pesquisar alimentos":
                    
                alimento_selecionado = input("\n Pesquise o alimento que deseja adicionar ao plano: ")
                resultado = taco.tabela_taco[taco.tabela_taco["Descrição dos alimentos"].str.contains(alimento_selecionado, case=False, na=False)]
                    
                if resultado.empty:
                    print(" ⚠️ Nenhum alimento encontrado! Tente novamente")
                else:
                    print(f"\n {len(resultado)} alimento(s) encontrado(s):\n")
                    for _, (_, row) in enumerate(resultado.iterrows(), 1):
                        print(f" {row['Descrição dos alimentos']}")
                        print(f" {'-'*80}")
                        print(f" 📈 Macronutrientes -> {row['Energia (kcal.)']} kcal | Proteína: {row['Proteína (g.)']}g | Carboidrato: {row['Carboidrato (g.)']}g | Lipídeos: {row['Lipídeos (g.)']}g")
                        print(f" 🍎 Fibra -> {row['Fibra.Alimentar (g.)']}g")
                        print(f" 🧂 Minerais -> Cálcio:{row['Cálcio (mg.)']}mg | Ferro:{row['Ferro (mg.)']}mg | Sódio:{row['Sódio (mg.)']}mg | Potássio:{row['Potássio (mg.)']}mg")
                        print(f" 🍊 Vitaminas -> A(RAE):{row['RAE (mcg.)']}mcg | C:{row['Vitamina.C (mg.)']}mg\n")
                        
                    opcoes = [f"{row['Descrição dos alimentos']}" for _, (_, row) in enumerate(resultado.iterrows(), 1)]
                    opcoes.append("🔎 Pesquisar alimento novamente")
                        
                    escolha = questionary.select("Selecione um alimento:",choices=opcoes, qmark="").ask()
                    if escolha == "🔎 Pesquisar alimento novamente":
                        continue
                    else:
                        refeicao_nome = i.strip()
                        escolher_medidas(refeicao_nome, escolha, totais_nutricionais, refeicoes_completas)
            else:
                break


    help.limpar_tela()
    print("✅ Plano alimentar criado com sucesso!")
    print("-" * 60)
    print("\n📊 RESUMO NUTRICIONAL DO PLANO:")
    print("-" * 60)
    print(f" 🔥 Calorias totais: {totais_nutricionais['calorias']:.1f} kcal")
    print(f" 🥩 Proteínas: {totais_nutricionais['proteina']:.1f}g")
    print(f" 🍚 Carboidratos: {totais_nutricionais['carboidrato']:.1f}g")
    print(f" 🧈 Lipídeos: {totais_nutricionais['lipideos']:.1f}g")
    print(f" 🍎 Fibras: {totais_nutricionais['fibra']:.1f}g")
    print(f"\n 🧂 Cálcio: {totais_nutricionais['calcio']:.1f}mg")
    print(f" 🧂 Ferro: {totais_nutricionais['ferro']:.1f}mg")
    print(f" 🧂 Sódio: {totais_nutricionais['sodio']:.1f}mg")
    print(f" 🧂 Potássio: {totais_nutricionais['potassio']:.1f}mg")
    print(f"\n 🍊 Vitamina A (RAE): {totais_nutricionais['vitamina_a']:.1f}mcg")
    print(f" 🍊 Vitamina C: {totais_nutricionais['vitamina_c']:.1f}mg")
    print("-" * 60)

    qr_observações = questionary.select("Deseja adicionar alguma observação?",choices=["Sim", "Não"],qmark="").ask()

    observacoes = ""
    if qr_observações == "Sim":
        observacoes = input("\n‼️ DIGITE AS OBSERVAÇÕES DO PLANO: ")

    time.sleep(3)
    input("\nPressione ENTER para voltar ao menu principal...")


    return refeicoes_completas, totais_nutricionais, observacoes
