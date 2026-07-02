from datetime import date, datetime
from db.conexoes import ConexaoDB

_MAPA_REFEICAO = {
    "CAFÉ DA MANHÃ":   "Café da manhã",
    "LANCHE DA MANHÃ": "Lanche da manhã",
    "ALMOÇO":          "Almoço",
    "LANCHE DA TARDE": "Lanche da tarde",
    "JANTAR":          "Jantar",
    "CEIA":            "Ceia",
}

_MAPA_REFEICAO_INVERSO = {
    "Café da manhã": "☕ CAFÉ DA MANHÃ ",
    "Lanche da manhã": "🥪 LANCHE DA MANHÃ",
    "Almoço": "🍽️ ALMOÇO",
    "Lanche da tarde": "🍉 LANCHE DA TARDE",
    "Jantar": "🍝 JANTAR",
    "Ceia": "🥛 CEIA",
}

_NUTRICIONISTA_ID = 1

def _lista_str(val):
    if isinstance(val, list):
        return ", ".join(val)
    return val or "Não se aplica"

def _str_lista(val):
    if not val or val == "Não se aplica":
        return []
    return [x.strip() for x in val.split(",")]

class PacienteDAO:
    @staticmethod
    def salvar_todos(pacientes_dict):
        conn = ConexaoDB.get()
        cursor = conn.cursor()

        for cpf, p in pacientes_dict.items():
            # 1. PACIENTE
            cursor.execute("""
                INSERT INTO paciente
                    (CPF, Nome, data_nasc, sexo, gravidez, etnia,
                     `profissão`, telefone, email,
                     nutricionista_id_nutricionista)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                    Nome     = VALUES(Nome),
                    data_nasc = VALUES(data_nasc),
                    sexo     = VALUES(sexo),
                    gravidez = VALUES(gravidez),
                    etnia    = VALUES(etnia),
                    `profissão` = VALUES(`profissão`),
                    telefone = VALUES(telefone),
                    email    = VALUES(email)
            """, (
                cpf, p.nome, p.data_nasc.strftime("%Y-%m-%d"), p.sexo,
                "SIM" if p.gravidez == "Sim" else "NAO", p.etnia,
                p.profissao, p.telefone, p.email, _NUTRICIONISTA_ID,
            ))

            # 2. ANAMNESE
            cursor.execute("""
                INSERT INTO paciente_anamnese (
                    objetivo, doencas_diagnosticadas, medicamentos_continuos,
                    intolerancias, alergias, freq_intestinal, qualidade_sono,
                    peso, altura, circunferencia_cintura, metodo_tmb,
                    nivel_atividadefisica, consumo_agua, alcoool,
                    meta_1, meta_2, meta_3,
                    peitoral, axilar_media, triceps, subescapular,
                    abdomen, suprailiaca, coxa,
                    paciente_CPF, paciente_nutricionista_id_nutricionista
                )
                VALUES (
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                )
                ON DUPLICATE KEY UPDATE
                    objetivo                       = VALUES(objetivo),
                    doencas_diagnosticadas         = VALUES(doencas_diagnosticadas),
                    medicamentos_continuos         = VALUES(medicamentos_continuos),
                    intolerancias                  = VALUES(intolerancias),
                    alergias                       = VALUES(alergias),
                    freq_intestinal                = VALUES(freq_intestinal),
                    qualidade_sono                 = VALUES(qualidade_sono),
                    peso                           = VALUES(peso),
                    altura                         = VALUES(altura),
                    circunferencia_cintura         = VALUES(circunferencia_cintura),
                    metodo_tmb                     = VALUES(metodo_tmb),
                    nivel_atividadefisica          = VALUES(nivel_atividadefisica),
                    consumo_agua                   = VALUES(consumo_agua),
                    alcoool                        = VALUES(alcoool),
                    meta_1                         = VALUES(meta_1),
                    meta_2                         = VALUES(meta_2),
                    meta_3                         = VALUES(meta_3),
                    peitoral                       = VALUES(peitoral),
                    axilar_media                   = VALUES(axilar_media),
                    triceps                        = VALUES(triceps),
                    subescapular                   = VALUES(subescapular),
                    abdomen                        = VALUES(abdomen),
                    suprailiaca                    = VALUES(suprailiaca),
                    coxa                           = VALUES(coxa)
            """, (
                p.objetivo, _lista_str(p.doencas), _lista_str(p.medicamentos),
                _lista_str(p.intolerancias), _lista_str(p.alergias), p.intestino,
                p.sono, p.peso, p.altura, p.medida_cintura, p.metodo_tmb, p.atividade_fisica,
                p.consumo_agua, p.alcool, p.meta_1, p.meta_2 or "Não se aplica",
                p.meta_3 or "Não se aplica", p.peitoral or 0, p.axilar_media or 0,
                p.triceps or 0, p.subescapular or 0, p.abdomen or 0,
                p.suprailiaca or 0, p.coxa or 0, cpf, _NUTRICIONISTA_ID,
            ))

            # 3. PLANO NUTRICIONAL
            # Deletar planos antigos e seus dependentes para manter 1 plano por paciente (simplificação)
            cursor.execute("SELECT idplano_nutricional FROM plano_nutricional WHERE paciente_cpf = %s", (cpf,))
            planos_antigos = cursor.fetchall()
            for pa in planos_antigos:
                pid = pa[0]
                cursor.execute("DELETE FROM `refeiçao_alimento` WHERE refeicoes_plano_nutricional_idplano_nutricional = %s AND refeicoes_plano_nutricional_paciente_cpf = %s", (pid, cpf))
                cursor.execute("DELETE FROM refeicoes WHERE plano_nutricional_idplano_nutricional = %s AND plano_nutricional_paciente_cpf = %s", (pid, cpf))
            cursor.execute("DELETE FROM plano_nutricional WHERE paciente_cpf = %s", (cpf,))

            if not p.plano:
                continue

            data_hoje = date.today().strftime("%Y-%m-%d")

            cursor.execute("""
                INSERT INTO plano_nutricional (paciente_cpf, data_plano, observacoes)
                VALUES (%s, %s, %s)
            """, (cpf, data_hoje, p.plano.get("observacoes", "")))

            cursor.execute("SELECT LAST_INSERT_ID()")
            plano_id = cursor.fetchone()[0]

            # 4. REFEIÇÕES + ALIMENTOS
            refeicoes_dict = p.plano.get("refeicoes", {})

            for nome_refeicao_python, itens in refeicoes_dict.items():
                if not itens:
                    continue

                nome_limpo = nome_refeicao_python.strip()
                partes = nome_limpo.split(" ", 1)
                if len(partes) == 2 and len(partes[0]) <= 2:
                    nome_limpo = partes[1].strip()

                nome_banco = _MAPA_REFEICAO.get(nome_limpo.upper())
                if not nome_banco:
                    continue

                cursor.execute("""
                    INSERT IGNORE INTO refeicoes
                        (data_refeicao, `nome_refeição`,
                         plano_nutricional_idplano_nutricional,
                         plano_nutricional_paciente_cpf,
                         plano_nutricional_data_plano)
                    VALUES (%s, %s, %s, %s, %s)
                """, (data_hoje, nome_banco, plano_id, cpf, data_hoje))

                for item in itens:
                    descricao_alimento = item.get("alimento")
                    if not descricao_alimento:
                        continue

                    cursor.execute("SELECT idalimentos FROM alimentos WHERE descricao = %s LIMIT 1", (descricao_alimento,))
                    alimento_row = cursor.fetchone()
                    if not alimento_row:
                        continue
                    id_alimento = alimento_row[0]

                    medida = item.get("medida", "Grama(s) (g)")
                    quantidade = item.get("quantidade") or 0

                    cursor.execute("""
                        INSERT IGNORE INTO `refeiçao_alimento` (
                            alimentos_idalimentos, quantidade, unidade_medida,
                            refeicoes_data_refeicao, `refeicoes_nome_refeição`,
                            refeicoes_plano_nutricional_idplano_nutricional,
                            refeicoes_plano_nutricional_paciente_cpf,
                            refeicoes_plano_nutricional_data_plano
                        )
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                    """, (id_alimento, quantidade, medida, data_hoje, nome_banco, plano_id, cpf, data_hoje))

        conn.commit()
        cursor.close()

    @staticmethod
    def carregar_todos():
        from models.pacientes import Paciente
        conn = ConexaoDB.get()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT p.*, a.* 
            FROM paciente p
            LEFT JOIN paciente_anamnese a ON p.CPF = a.paciente_CPF
            WHERE p.nutricionista_id_nutricionista = %s
        """, (_NUTRICIONISTA_ID,))
        
        linhas = cursor.fetchall()
        pacientes_dict = {}

        for row in linhas:
            data_nasc_val = row["data_nasc"]
            if isinstance(data_nasc_val, str):
                data_nasc = datetime.strptime(data_nasc_val, "%Y-%m-%d")
            else:
                data_nasc = data_nasc_val
                
            cpf = row["CPF"]
            
            p = Paciente(
                nome=row["Nome"], data_nasc=data_nasc, sexo=row["sexo"],
                gravidez="Sim" if row["gravidez"] == "SIM" else "Não",
                etnia=row["etnia"], profissao=row["profissão"],
                telefone=row["telefone"], cpf=cpf, email=row["email"],
                objetivo=row.get("objetivo", "Manutenção"),
                doencas=_str_lista(row.get("doencas_diagnosticadas", "")),
                medicamentos=_str_lista(row.get("medicamentos_continuos", "")),
                alergias=_str_lista(row.get("alergias", "")),
                intolerancias=_str_lista(row.get("intolerancias", "")),
                intestino=row.get("freq_intestinal", "1x ao dia (normal)"),
                sono=row.get("qualidade_sono", "Boa"),
                peso=row.get("peso", 0.0),
                altura=row.get("altura", 0.0),
                medida_cintura=row.get("circunferencia_cintura", 0.0),
                metodo_tmb=row.get("metodo_tmb", "Harris-Benedict (padrão geral)"),
                atividade_fisica=row.get("nivel_atividadefisica", "Sedentário"),
                consumo_agua=row.get("consumo_agua", "Entre 2 L e 3 L/dia"),
                alcool=row.get("alcoool", "Não consome"),
                meta_1=row.get("meta_1", ""),
                meta_2=row.get("meta_2", "Não se aplica"),
                meta_3=row.get("meta_3", "Não se aplica"),
                peitoral=row.get("peitoral", None),
                axilar_media=row.get("axilar_media", None),
                triceps=row.get("triceps", None),
                subescapular=row.get("subescapular", None),
                abdomen=row.get("abdomen", None),
                suprailiaca=row.get("suprailiaca", None),
                coxa=row.get("coxa", None)
            )
            
            # Calcular todos os campos automáticos
            p.calcular_tudo()
            
            # Carregar Plano
            cursor.execute("""
                SELECT 
                    r.`nome_refeição`,
                    ra.quantidade,
                    ra.unidade_medida,
                    a.descricao,
                    a.energia_kcal,
                    a.proteina,
                    a.carboidrato,
                    a.lipideos,
                    a.fibra_alimentar,
                    a.calcio,
                    a.ferro,
                    a.sodio,
                    a.potassio,
                    a.rae as vitamina_a,
                    a.vitamina_c,
                    pl.observacoes
                FROM plano_nutricional pl
                JOIN refeicoes r ON r.plano_nutricional_idplano_nutricional = pl.idplano_nutricional
                JOIN `refeiçao_alimento` ra ON ra.refeicoes_data_refeicao = r.data_refeicao 
                    AND ra.`refeicoes_nome_refeição` = r.`nome_refeição`
                    AND ra.refeicoes_plano_nutricional_idplano_nutricional = pl.idplano_nutricional
                JOIN alimentos a ON a.idalimentos = ra.alimentos_idalimentos
                WHERE pl.paciente_cpf = %s
            """, (cpf,))
            
            itens_plano = cursor.fetchall()
            if itens_plano:
                refeicoes = ["☕ CAFÉ DA MANHÃ ", "🥪 LANCHE DA MANHÃ", "🍽️ ALMOÇO", "🍉 LANCHE DA TARDE", "🍝 JANTAR", "🥛 CEIA"]
                refeicoes_completas = {r.strip(): [] for r in refeicoes}
                
                totais_nutricionais = {
                    "calorias": 0, "proteina": 0, "carboidrato": 0, "lipideos": 0, "fibra": 0,
                    "calcio": 0, "ferro": 0, "sodio": 0, "potassio": 0, "vitamina_a": 0, "vitamina_c": 0
                }
                
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
                
                for item_row in itens_plano:
                    refeicao_banco = item_row["nome_refeição"]
                    refeicao_python = _MAPA_REFEICAO_INVERSO.get(refeicao_banco, refeicao_banco).strip()
                    
                    qtd_medida = item_row["quantidade"]
                    def_medida = item_row["unidade_medida"]
                    
                    if def_medida == "À vontade":
                        qtd_medida = None
                        fator = 0
                    else:
                        fator = qtd_medida * conversoes.get(def_medida, 1)
                        
                    def somar_nut(valor):
                        if valor is None or valor == "-": return 0
                        try: return (float(valor) * fator) / 100
                        except: return 0
                        
                    item = {
                        "alimento": item_row["descricao"],
                        "medida": def_medida,
                        "quantidade": qtd_medida,
                        "calorias": somar_nut(item_row["energia_kcal"]),
                        "proteina": somar_nut(item_row["proteina"]),
                        "carboidrato": somar_nut(item_row["carboidrato"]),
                        "lipideos": somar_nut(item_row["lipideos"]),
                        "fibra": somar_nut(item_row["fibra_alimentar"]),
                        "calcio": somar_nut(item_row["calcio"]),
                        "ferro": somar_nut(item_row["ferro"]),
                        "sodio": somar_nut(item_row["sodio"]),
                        "potassio": somar_nut(item_row["potassio"]),
                        "vitamina_a": somar_nut(item_row["vitamina_a"]),
                        "vitamina_c": somar_nut(item_row["vitamina_c"])
                    }
                    
                    for nutriente in totais_nutricionais:
                        totais_nutricionais[nutriente] += item[nutriente]
                        
                    if refeicao_python in refeicoes_completas:
                        refeicoes_completas[refeicao_python].append(item)
                        
                obs_banco = itens_plano[0].get("observacoes", "")
                
                p.plano = {
                    "refeicoes": refeicoes_completas,
                    "totais": totais_nutricionais,
                    "observacoes": obs_banco
                }
                
            pacientes_dict[cpf] = p

        cursor.close()
        return pacientes_dict

    @staticmethod
    def deletar_paciente(cpf):
        conn = ConexaoDB.get()
        cursor = conn.cursor()
        
        # Como as foreign keys no script não têm ON DELETE CASCADE, precisamos deletar em ordem reversa
        
        # 1. Obter IDs dos planos do paciente
        cursor.execute("SELECT idplano_nutricional FROM plano_nutricional WHERE paciente_cpf = %s", (cpf,))
        planos = cursor.fetchall()
        
        for plano_id in planos:
            pid = plano_id[0]
            # Deletar refeiçao_alimento
            cursor.execute("DELETE FROM `refeiçao_alimento` WHERE refeicoes_plano_nutricional_idplano_nutricional = %s AND refeicoes_plano_nutricional_paciente_cpf = %s", (pid, cpf))
            # Deletar refeicoes
            cursor.execute("DELETE FROM refeicoes WHERE plano_nutricional_idplano_nutricional = %s AND plano_nutricional_paciente_cpf = %s", (pid, cpf))
            
        # Deletar planos
        cursor.execute("DELETE FROM plano_nutricional WHERE paciente_cpf = %s", (cpf,))
        
        # Deletar anamnese
        cursor.execute("DELETE FROM paciente_anamnese WHERE paciente_CPF = %s", (cpf,))
        
        # Deletar paciente
        cursor.execute("DELETE FROM paciente WHERE CPF = %s", (cpf,))
        
        conn.commit()
        cursor.close()
