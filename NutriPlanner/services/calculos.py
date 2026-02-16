def calculo_imc(paciente):
    return paciente.peso / ((paciente.altura / 100) ** 2)


def classificar_imc(imc_atual, paciente):
    if paciente.etnia == "Amarela":
        if imc_atual < 18.5:
            return "Abaixo do peso"
        elif imc_atual < 23:
            return "Peso saudável"
        elif imc_atual < 25:
            return "Sobrepeso"
        else:
            return "Obesidade"
    else:
        if imc_atual < 18.5:
            return "Abaixo do peso"
        elif imc_atual < 25:
            return "Peso saudável"
        elif imc_atual < 30:
            return "Sobrepeso"
        else:
            return "Obesidade"


def calculo_ca(paciente):
    return paciente.medida_cintura / paciente.altura


def classificar_relacao_ca(relacao_ca, paciente):
    if relacao_ca < 0.40:
        return "Muito magro"
    elif relacao_ca < 0.50:
        return "Saudável"
    elif relacao_ca < 0.60:
        return "Risco aumentado"
    else:
        return "Risco alto"


def calculo_tmb(paciente):

    if paciente.metodo_tmb == "Harris-Benedict (padrão geral)":
        if paciente.sexo == "F":
            return 447.593 + (9.247 * paciente.peso) + (3.098 * paciente.altura) - (4.330 * paciente.idade)
        else:
            return 88.362 + (13.397 * paciente.peso) + (4.799 * paciente.altura) - (5.677 * paciente.idade)

    else:
        if paciente.sexo == "F":
            return (10 * paciente.peso) + (6.25 * paciente.altura) - (5 * paciente.idade) - 161
        else:
            return (10 * paciente.peso) + (6.25 * paciente.altura) - (5 * paciente.idade) + 5


def calculo_gasto_total(paciente):
    if paciente.atividade_fisica == "Sedentário (não pratica exercícios)":
        fator = 1.2
    elif paciente.atividade_fisica == "Leve (1–2x por semana)":
        fator = 1.375
    elif paciente.atividade_fisica == "Moderado (3–4x por semana)":
        fator = 1.55
    elif paciente.atividade_fisica == "Intenso (5–6x por semana)":
        fator = 1.725
    elif paciente.atividade_fisica == "Atleta/treino diário":
        fator = 1.9
    elif paciente.atividade_fisica == "Trabalho fisicamente ativo (ex.: estoquista, operário)":
        fator = 1.725
    else:
        fator = 1.2

    return paciente.tmb * fator


def calcular_proteinas(paciente):

    if paciente.objetivo == "Emagrecimento":
        prot_min = 1.8
        prot_max = 2.2
    elif paciente.objetivo == "Manutenção":
        prot_min = 1.6
        prot_max = 1.8
    else:
        prot_min = 1.6
        prot_max = 2.0

    if paciente.imc_atual >= 30:
        prot_min += 0.2
        prot_max += 0.2

    min_gramas = paciente.peso * prot_min
    max_gramas = paciente.peso * prot_max

    min_kcal = min_gramas * 4
    max_kcal = max_gramas * 4

    return min_gramas, max_gramas, min_kcal, max_kcal


def calcular_gorduras(paciente):

    if paciente.objetivo == "Emagrecimento":
        gord_min = 0.6
        gord_max = 0.8
    elif paciente.objetivo == "Manutenção":
        gord_min = 0.8
        gord_max = 1.0
    else:
        gord_min = 0.9
        gord_max = 1.1

    if paciente.imc_atual >= 30:
        gord_min -= 0.1

    min_gramas = paciente.peso * gord_min
    max_gramas = paciente.peso * gord_max

    min_kcal = min_gramas * 9
    max_kcal = max_gramas * 9

    return min_gramas, max_gramas, min_kcal, max_kcal


def calcular_carboidratos(paciente):

    if paciente.objetivo == "Emagrecimento":
        pct_min = 0.35
        pct_max = 0.45
    elif paciente.objetivo == "Manutenção":
        pct_min = 0.40
        pct_max = 0.55
    else:
        pct_min = 0.45
        pct_max = 0.60

    min_kcal = paciente.gasto_total * pct_min
    max_kcal = paciente.gasto_total * pct_max

    min_gramas = min_kcal / 4
    max_gramas = max_kcal / 4

    return min_gramas, max_gramas, min_kcal, max_kcal


def calcular_fibras(paciente):

    if paciente.sexo == "F":
        fibra_min = 25
        fibra_max = 30
    else:
        fibra_min = 30
        fibra_max = 38

    if paciente.objetivo == "Emagrecimento":
        fibra_min += 5
        fibra_max += 5

    ajustes_intestino = {
        "1x ao dia (normal)": 0,
        "2x ao dia": -3,
        "A cada 2 dias": +3,
        "A cada 3 dias": +5,
        "A cada 4–5 dias": +8,
        "Menos de 1x por semana": +10
    }
    fibra_min += ajustes_intestino.get(paciente.intestino, 0)
    fibra_max += ajustes_intestino.get(paciente.intestino, 0)

    ajustes_sono = {
        "Excelente (sono reparador)": 0,
        "Bom (dorme bem na maioria dos dias)": 0,
        "Regular (acorda algumas vezes, sono leve)": 2,
        "Ruim (dificuldade para dormir ou manter o sono)": 4,
        "Insônia (demora para dormir ou acorda muitas vezes)": 5
    }
    fibra_min += ajustes_sono.get(paciente.sono, 0)
    fibra_max += ajustes_sono.get(paciente.sono, 0)

    fibra_min = max(20, fibra_min)
    fibra_max = min(45, fibra_max)

    return fibra_min, fibra_max


def minerais(paciente):
    if paciente.sexo == "F":
        calcio_min = 1000; calcio_max = 2500
        ferro_min = 18; ferro_max = 45
        magnesio_min = 310; magnesio_max = 350
        zinco_min = 8; zinco_max = 40
        cobre_min = 0.9; cobre_max = 10
        manganes_min = 1.8; manganes_max = 11
        selenio_min = 55; selenio_max = 400
        iodo_min = 150; iodo_max = 1100
        sodio_min = 500; sodio_max = 2300
        potassio_min = 2600; potassio_max = None
        fosforo_min = 700; fosforo_max = 4000

    elif paciente.sexo == "F" and paciente.gravidez == "Sim":
        calcio_min = 1000; calcio_max = 2500
        ferro_min = 27; ferro_max = 45
        magnesio_min = 350; magnesio_max = 350
        zinco_min = 11; zinco_max = 40
        cobre_min = 1.0; cobre_max = 10
        manganes_min = 2.0; manganes_max = 11
        selenio_min = 60; selenio_max = 400
        iodo_min = 220; iodo_max = 1100
        sodio_min = 500; sodio_max = 2300
        potassio_min = 2900; potassio_max = None
        fosforo_min = 700; fosforo_max = 4000

    else:
        calcio_min = 1000; calcio_max = 2500
        ferro_min = 8; ferro_max = 45
        magnesio_min = 400; magnesio_max = 350
        zinco_min = 11; zinco_max = 40
        cobre_min = 0.9; cobre_max = 10
        manganes_min = 2.3; manganes_max = 11
        selenio_min = 55; selenio_max = 400
        iodo_min = 150; iodo_max = 1100
        sodio_min = 500; sodio_max = 2300
        potassio_min = 3400; potassio_max = None
        fosforo_min = 700; fosforo_max = 4000

    return {
        "calcio": (calcio_min, calcio_max),
        "ferro": (ferro_min, ferro_max),
        "magnesio": (magnesio_min, magnesio_max),
        "zinco": (zinco_min, zinco_max),
        "cobre": (cobre_min, cobre_max),
        "manganes": (manganes_min, manganes_max),
        "selenio": (selenio_min, selenio_max),
        "iodo": (iodo_min, iodo_max),
        "sodio": (sodio_min, sodio_max),
        "potassio": (potassio_min, potassio_max),
        "fosforo": (fosforo_min, fosforo_max)
    }


def vitaminas(paciente):
    if paciente.sexo == "F":
        vitamina_a_min = 700; vitamina_a_max = 3000
        vitamina_d_min = 600; vitamina_d_max = 4000
        vitamina_e_min = 15; vitamina_e_max = 1000
        vitamina_k_min = 90; vitamina_k_max = None

        vitamina_c_min = 75; vitamina_c_max = 2000
        b1_min = 1.1; b1_max = None
        b2_min = 1.1; b2_max = None
        b3_min = 14; b3_max = 35
        b6_min = 1.3; b6_max = 100
        b9_min = 400; b9_max = 1000
        b12_min = 2.4; b12_max = None
        b5_min = 5; b5_max = None
        b7_min = 30; b7_max = None
    
    elif paciente.sexo == "F" and paciente.gravidez == "Sim":
        vitamina_a_min = 770; vitamina_a_max = 3000
        vitamina_d_min = 600; vitamina_d_max = 4000
        vitamina_e_min = 15; vitamina_e_max = 1000
        vitamina_k_min = 90; vitamina_k_max = None

        vitamina_c_min = 85; vitamina_c_max = 2000
        b1_min = 1.4; b1_max = None
        b2_min = 1.4; b2_max = None
        b3_min = 18; b3_max = 35
        b6_min = 1.9; b6_max = 100
        b9_min = 600; b9_max = 1000
        b12_min = 2.6; b12_max = None
        b5_min = 6; b5_max = None
        b7_min = 30; b7_max = None

    else:
        vitamina_a_min = 900; vitamina_a_max = 3000
        vitamina_d_min = 600; vitamina_d_max = 4000
        vitamina_e_min = 15; vitamina_e_max = 1000
        vitamina_k_min = 120; vitamina_k_max = None

        vitamina_c_min = 90; vitamina_c_max = 2000
        b1_min = 1.2; b1_max = None
        b2_min = 1.3; b2_max = None
        b3_min = 16; b3_max = 35
        b6_min = 1.3; b6_max = 100
        b9_min = 400; b9_max = 1000
        b12_min = 2.4; b12_max = None
        b5_min = 5; b5_max = None
        b7_min = 30; b7_max = None

    return {
        "vitamina_a": (vitamina_a_min, vitamina_a_max),
        "vitamina_d": (vitamina_d_min, vitamina_d_max),
        "vitamina_e": (vitamina_e_min, vitamina_e_max),
        "vitamina_k": (vitamina_k_min, vitamina_k_max),

        "vitamina_c": (vitamina_c_min, vitamina_c_max),
        "vitamina_b1": (b1_min, b1_max),
        "vitamina_b2": (b2_min, b2_max),
        "vitamina_b3": (b3_min, b3_max),
        "vitamina_b6": (b6_min, b6_max),
        "vitamina_b9": (b9_min, b9_max),
        "vitamina_b12": (b12_min, b12_max),
        "vitamina_b5": (b5_min, b5_max),
        "vitamina_b7": (b7_min, b7_max)
    }

def acidos_graxos(paciente):
    if paciente.sexo == "F":
        omega3_min = 1.1
        omega3_max = None

        epa_dha_min = 250
        epa_dha_max = 500

        omega6_min = 12
        omega6_max = None

    elif paciente.sexo == "F" and paciente.gravidez == "Sim":
        omega3_min = 1.4
        omega3_max = None

        epa_dha_min = 300
        epa_dha_max = 1000

        omega6_min = 13
        omega6_max = None

    else:
        omega3_min = 1.6
        omega3_max = None

        epa_dha_min = 250
        epa_dha_max = 500

        omega6_min = 17
        omega6_max = None

    return {
        "omega3_total": (omega3_min, omega3_max),
        "epa_dha": (epa_dha_min, epa_dha_max),
        "omega6": (omega6_min, omega6_max)}

def converter_consumo_agua(consumo):
    mapa = {
        "Menos de 500 ml/dia": 400,
        "Entre 500 ml e 1 L/dia": 750,
        "Entre 1 L e 1,5 L/dia": 1200,
        "Entre 1,5 L e 2 L/dia": 1700,
        "Entre 2 L e 3 L/dia": 2500,
        "Mais de 3 L/dia": 3200
    }
    return mapa.get(consumo, 0)

def calcular_hidratacao(paciente):
    peso = paciente.peso

    agua_base = peso * 35

    nivel = paciente.atividade_fisica

    if nivel == "Sedentário (não pratica exercícios)":
        ajuste_atividade = 0
    elif nivel == "Leve (1–2x por semana)":
        ajuste_atividade = 300
    elif nivel == "Moderado (3–4x por semana)":
        ajuste_atividade = 500
    elif nivel == "Intenso (5–6x por semana)":
        ajuste_atividade = 800
    elif nivel == "Atleta/treino diário":
        ajuste_atividade = 1000
    else:
        ajuste_atividade = 1200

    if paciente.objetivo == "Emagrecimento":
        ajuste_objetivo = agua_base * 0.10
    else:
        ajuste_objetivo = 0

    consumo_alcool = paciente.alcool

    if consumo_alcool == "Não consome":
        ajuste_alcool = 0
    elif consumo_alcool == "Raramente (1x/mês ou menos)":
        ajuste_alcool = 150
    elif consumo_alcool == "Socialmente (2–4x/mês)":
        ajuste_alcool = 250
    elif consumo_alcool == "1x por semana":
        ajuste_alcool = 300
    elif consumo_alcool == "2–3x por semana":
        ajuste_alcool = 400
    else:
        ajuste_alcool = 500

    agua_total = agua_base + ajuste_atividade + ajuste_objetivo + ajuste_alcool
    litros = agua_total / 1000

    consumo_atual = converter_consumo_agua(paciente.consumo_agua)

    if consumo_atual < agua_total * 0.60:
        alerta = "⚠️ ALERTA: O consumo atual de água está MUITO abaixo do recomendado!"
    elif consumo_atual < agua_total * 0.85:
        alerta = "⚠️ Atenção: O consumo atual de água está abaixo do ideal."
    else:
        alerta = "✅ O consumo atual de água está dentro do recomendado."

    return round(agua_total), round(litros, 2), alerta
