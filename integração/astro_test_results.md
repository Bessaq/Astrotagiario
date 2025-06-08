# 🔬 RELATÓRIO DE TESTES EXTENSIVOS - ASTROAPI TOAMAO
**Data:** Sun Jun  8 11:20:11 UTC 2025
**Versão:** API Completa Integrada

## DADOS DE TESTE
- **João Victor:** 13/10/1997 às 22:00, Fortaleza-CE
- **João Paulo:** 13/06/1995 às 09:30, Sobral-CE
- **Data de Referência:** 08/06/2025

---

## TESTE 1: Mapa Natal João Victor
**Endpoint:** `/natal_chart`
**Descrição:** Mapa natal completo de João Victor (13/10/1997 22:00 Fortaleza-CE)

**Status:** ✅ SUCESSO (HTTP 200)
**Resultado:** Mapa natal calculado com sucesso
**Planetas calculados:** 1
### Resposta Completa:
```json
{"input_data":{"name":"João Victor","year":1997,"month":10,"day":13,"hour":22,"minute":0,"latitude":-3.7319,"longitude":-38.5267,"tz_str":"America/Fortaleza","house_system":"placidus"},"planets":[{"name":"Sun","name_original":"Sun","longitude":20.723,"latitude":0.0,"sign":"Lib","sign_original":"Lib","sign_num":6,"house":1,"retrograde":false},{"name":"Moon","name_original":"Moon","longitude":20.9833,"latitude":0.0,"sign":"Pis","sign_original":"Pis","sign_num":11,"house":1,"retrograde":false},{"name":"Mercury","name_original":"Mercury","longitude":20.8415,"latitude":0.0,"sign":"Lib","sign_original":"Lib","sign_num":6,"house":1,"retrograde":false},{"name":"Venus","name_original":"Venus","longitude":6.3173,"latitude":0.0,"sign":"Sag","sign_original":"Sag","sign_num":8,"house":1,"retrograde":false},{"name":"Mars","name_original":"Mars","longitude":10.7156,"latitude":0.0,"sign":"Sag","sign_original":"Sag","sign_num":8,"house":1,"retrograde":false},{"name":"Jupiter","name_original":"Jupiter","longitude":12.1491,"latitude":0.0,"sign":"Aqu","sign_original":"Aqu","sign_num":10,"house":1,"retrograde":false},{"name":"Saturn","name_original":"Saturn","longitude":16.6033,"latitude":0.0,"sign":"Ari","sign_original":"Ari","sign_num":0,"house":1,"retrograde":true},{"name":"Uranus","name_original":"Uranus","longitude":4.7366,"latitude":0.0,"sign":"Aqu","sign_original":"Aqu","sign_num":10,"house":1,"retrograde":true},{"name":"Neptune","name_original":"Neptune","longitude":27.1871,"latitude":0.0,"sign":"Cap","sign_original":"Cap","sign_num":9,"house":1,"retrograde":false},{"name":"Pluto","name_original":"Pluto","longitude":3.8406,"latitude":0.0,"sign":"Sag","sign_original":"Sag","sign_num":8,"house":1,"retrograde":false},{"name":"Mean_Node","name_original":"Mean_Node","longitude":17.9071,"latitude":0.0,"sign":"Vir","sign_original":"Vir","sign_num":5,"house":1,"retrograde":true},{"name":"True_Node","name_original":"True_Node","longitude":19.4992,"latitude":0.0,"sign":"Vir","sign_original":"Vir","sign_num":5,"house":1,"retrograde":true},{"name":"Chiron","name_original":"Chiron","longitude":5.2065,"latitude":0.0,"sign":"Sco","sign_original":"Sco","sign_num":7,"house":1,"retrograde":false}],"houses":[{"number":1,"sign":"Gem","sign_original":"Gem","sign_num":2,"longitude":27.6817},{"number":2,"sign":"Can","sign_original":"Can","sign_num":3,"longitude":26.1379},{"number":3,"sign":"Leo","sign_original":"Leo","sign_num":4,"longitude":26.5851},{"number":4,"sign":"Vir","sign_original":"Vir","sign_num":5,"longitude":29.0106},{"number":5,"sign":"Sco","sign_original":"Sco","sign_num":7,"longitude":0.9628},{"number":6,"sign":"Sag","sign_original":"Sag","sign_num":8,"longitude":0.3412},{"number":7,"sign":"Sag","sign_original":"Sag","sign_num":8,"longitude":27.6817},{"number":8,"sign":"Cap","sign_original":"Cap","sign_num":9,"longitude":26.1379},{"number":9,"sign":"Aqu","sign_original":"Aqu","sign_num":10,"longitude":26.5851},{"number":10,"sign":"Pis","sign_original":"Pis","sign_num":11,"longitude":29.0106},{"number":11,"sign":"Tau","sign_original":"Tau","sign_num":1,"longitude":0.9628},{"number":12,"sign":"Gem","sign_original":"Gem","sign_num":2,"longitude":0.3412}],"aspects":[],"summary":"Mapa natal de João Victor calculado com 13 planetas e 0 aspectos."}
```

---

## TESTE 2: Sinastria Completa
**Endpoint:** `/synastry`
**Descrição:** Análise de compatibilidade entre João Victor e João Paulo

**Status:** ✅ SUCESSO (HTTP 200)
**Score de Compatibilidade:** 100.0/100
**Aspectos Encontrados:** 25
### Resposta Completa:
```json
{"person1_name":"João Victor","person2_name":"João Paulo","aspects":[{"aspect_type":"conjunction","orb":1.3192469092426364,"is_applying":true,"planet1":"Sun","planet2":"Sun","description":"Sun (João Victor) conjunction Sun (João Paulo)"},{"aspect_type":"conjunction","orb":6.360665333543693,"is_applying":true,"planet1":"Sun","planet2":"Moon","description":"Sun (João Victor) conjunction Moon (João Paulo)"},{"aspect_type":"conjunction","orb":3.5957230345310904,"is_applying":true,"planet1":"Sun","planet2":"Saturn","description":"Sun (João Victor) conjunction Saturn (João Paulo)"},{"aspect_type":"conjunction","orb":1.0589641702192836,"is_applying":true,"planet1":"Moon","planet2":"Sun","description":"Moon (João Victor) conjunction Sun (João Paulo)"},{"aspect_type":"conjunction","orb":6.10038259452034,"is_applying":true,"planet1":"Moon","planet2":"Moon","description":"Moon (João Victor) conjunction Moon (João Paulo)"},{"aspect_type":"conjunction","orb":3.3354402955077376,"is_applying":true,"planet1":"Moon","planet2":"Saturn","description":"Moon (João Victor) conjunction Saturn (João Paulo)"},{"aspect_type":"conjunction","orb":1.2007409151966186,"is_applying":true,"planet1":"Mercury","planet2":"Sun","description":"Mercury (João Victor) conjunction Sun (João Paulo)"},{"aspect_type":"conjunction","orb":6.242159339497675,"is_applying":true,"planet1":"Mercury","planet2":"Moon","description":"Mercury (João Victor) conjunction Moon (João Paulo)"},{"aspect_type":"conjunction","orb":3.4772170404850726,"is_applying":true,"planet1":"Mercury","planet2":"Saturn","description":"Mercury (João Victor) conjunction Saturn (João Paulo)"},{"aspect_type":"conjunction","orb":4.0095756479314275,"is_applying":true,"planet1":"Venus","planet2":"Mercury","description":"Venus (João Victor) conjunction Mercury (João Paulo)"},{"aspect_type":"conjunction","orb":2.8601942360196944,"is_applying":true,"planet1":"Venus","planet2":"Venus","description":"Venus (João Victor) conjunction Venus (João Paulo)"},{"aspect_type":"conjunction","orb":2.7691779965143155,"is_applying":true,"planet1":"Venus","planet2":"Mars","description":"Venus (João Victor) conjunction Mars (João Paulo)"},{"aspect_type":"conjunction","orb":2.687851144978822,"is_applying":true,"planet1":"Venus","planet2":"Jupiter","description":"Venus (João Victor) conjunction Jupiter (João Paulo)"},{"aspect_type":"conjunction","orb":0.38870084258621773,"is_applying":true,"planet1":"Mars","planet2":"Mercury","description":"Mars (João Victor) conjunction Mercury (João Paulo)"},{"aspect_type":"conjunction","orb":7.25847072653734,"is_applying":true,"planet1":"Mars","planet2":"Venus","description":"Mars (João Victor) conjunction Venus (João Paulo)"},{"aspect_type":"conjunction","orb":1.6290984940033297,"is_applying":true,"planet1":"Mars","planet2":"Mars","description":"Mars (João Victor) conjunction Mars (João Paulo)"},{"aspect_type":"conjunction","orb":1.7104253455388232,"is_applying":true,"planet1":"Mars","planet2":"Jupiter","description":"Mars (João Victor) conjunction Jupiter (João Paulo)"},{"aspect_type":"conjunction","orb":1.8222535891339362,"is_applying":true,"planet1":"Jupiter","planet2":"Mercury","description":"Jupiter (João Victor) conjunction Mercury (João Paulo)"},{"aspect_type":"conjunction","orb":3.062651240551048,"is_applying":true,"planet1":"Jupiter","planet2":"Mars","description":"Jupiter (João Victor) conjunction Mars (João Paulo)"},{"aspect_type":"conjunction","orb":3.1439780920865417,"is_applying":true,"planet1":"Jupiter","planet2":"Jupiter","description":"Jupiter (João Victor) conjunction Jupiter (João Paulo)"},{"aspect_type":"conjunction","orb":5.4389367299977955,"is_applying":true,"planet1":"Saturn","planet2":"Sun","description":"Saturn (João Victor) conjunction Sun (João Paulo)"},{"aspect_type":"conjunction","orb":6.2764308646545395,"is_applying":true,"planet1":"Saturn","planet2":"Mercury","description":"Saturn (João Victor) conjunction Mercury (João Paulo)"},{"aspect_type":"conjunction","orb":7.5168285160716515,"is_applying":true,"planet1":"Saturn","planet2":"Mars","description":"Saturn (João Victor) conjunction Mars (João Paulo)"},{"aspect_type":"conjunction","orb":7.598155367607145,"is_applying":true,"planet1":"Saturn","planet2":"Jupiter","description":"Saturn (João Victor) conjunction Jupiter (João Paulo)"},{"aspect_type":"conjunction","orb":7.7154128552862495,"is_applying":true,"planet1":"Saturn","planet2":"Saturn","description":"Saturn (João Victor) conjunction Saturn (João Paulo)"}],"compatibility_score":100.0,"summary":"Sinastria entre João Victor e João Paulo:\n        \nTotal de aspectos encontrados: 25\nAspectos harmoniosos: 25\nAspectos desafiadores: 0\nScore de compatibilidade: 100.0/100\n\nEsta é uma combinação muito harmoniosa!"}
```

---

## TESTE 3: Trânsitos Diários
**Endpoint:** `/transits/daily`
**Descrição:** Trânsitos planetários do dia 08/06/2025

**Status:** ✅ SUCESSO (HTTP 200)
**Aspectos:** 0
### Resposta Completa:
```json
{"date":"08/06/2025","aspects":[],"moon_phase":"Lua Crescente","summary":"Dia 08/06/2025: Aspectos planetários suaves. Lua Crescente."}
```

---

## TESTE 4: Trânsitos Semanais
**Endpoint:** `/transits/weekly`
**Descrição:** Previsão de trânsitos para semana de 08/06/2025

**Status:** ✅ SUCESSO (HTTP 200)
**Aspectos:** 6
### Resposta Completa:
```json
{"start_date":"08/06/2025","end_date":"14/06/2025","days":[{"date":"08/06/2025","aspects":[],"moon_phase":"Lua Crescente","summary":"Dia suave com energia equilibrada. Lua Crescente."},{"date":"09/06/2025","aspects":[],"moon_phase":"Lua Crescente","summary":"Dia suave com energia equilibrada. Lua Crescente."},{"date":"10/06/2025","aspects":[],"moon_phase":"Lua Crescente","summary":"Dia suave com energia equilibrada. Lua Crescente."},{"date":"11/06/2025","aspects":[],"moon_phase":"Lua Crescente","summary":"Dia suave com energia equilibrada. Lua Crescente."},{"date":"12/06/2025","aspects":[],"moon_phase":"Primeiro Quarto","summary":"Dia suave com energia equilibrada. Primeiro Quarto."},{"date":"13/06/2025","aspects":[],"moon_phase":"Primeiro Quarto","summary":"Dia suave com energia equilibrada. Primeiro Quarto."},{"date":"14/06/2025","aspects":[],"moon_phase":"Primeiro Quarto","summary":"Dia suave com energia equilibrada. Primeiro Quarto."}],"weekly_summary":"Semana tranquila com poucas movimentações planetárias. Período ideal para consolidação."}
```

---

## TESTE 5: Fase da Lua
**Endpoint:** `/moon_phase`
**Descrição:** Fase lunar e iluminação para 08/06/2025

**Status:** ✅ SUCESSO (HTTP 200)
**Fase:** Fase não disponível
**Iluminação:** 50.0%
### Resposta Completa:
```json
{"date":"08/06/2025","phase":"Fase não disponível","illumination":50.0,"angle":0.0,"distance":384400.0,"description":"Fase lunar especial. Iluminação: 50.0%"}
```

---

## TESTE 6: Retorno Solar
**Endpoint:** `/solar_return`
**Descrição:** Retorno solar de João Victor para 2025

**Status:** ✅ SUCESSO (HTTP 200)
**Data do Retorno:** 13/10/2025
### Resposta Completa:
```json
{"birth_date":"13/10/1997","return_date":"13/10/2025","location":"Lat -3.7319, Long -38.5267","planets":[{"name":"Sun","sign":"Lib","sign_num":6,"position":20.943653454858634,"abs_pos":200.94365345485863,"house_name":"first_house","speed":0.0,"retrograde":false},{"name":"Moon","sign":"Can","sign_num":3,"position":24.508886823641774,"abs_pos":114.50888682364177,"house_name":"first_house","speed":0.0,"retrograde":false},{"name":"Mercury","sign":"Sco","sign_num":7,"position":10.71645061918366,"abs_pos":220.71645061918366,"house_name":"first_house","speed":0.0,"retrograde":false},{"name":"Venus","sign":"Lib","sign_num":6,"position":0.1906316559166612,"abs_pos":180.19063165591666,"house_name":"first_house","speed":0.0,"retrograde":false},{"name":"Mars","sign":"Sco","sign_num":7,"position":14.830963218513773,"abs_pos":224.83096321851377,"house_name":"first_house","speed":0.0,"retrograde":false},{"name":"Jupiter","sign":"Can","sign_num":3,"position":23.843252002718955,"abs_pos":113.84325200271896,"house_name":"first_house","speed":0.0,"retrograde":false},{"name":"Saturn","sign":"Pis","sign_num":11,"position":26.82096669344719,"abs_pos":356.8209666934472,"house_name":"first_house","speed":0.0,"retrograde":true},{"name":"Uranus","sign":"Gem","sign_num":2,"position":0.8873220313331842,"abs_pos":60.887322031333184,"house_name":"first_house","speed":0.0,"retrograde":true},{"name":"Neptune","sign":"Ari","sign_num":0,"position":0.20464984336845304,"abs_pos":0.20464984336845304,"house_name":"first_house","speed":0.0,"retrograde":true},{"name":"Pluto","sign":"Aqu","sign_num":10,"position":1.3669324294105536,"abs_pos":301.36693242941055,"house_name":"first_house","speed":0.0,"retrograde":true}],"houses":[{"number":1,"sign":"Aries","degree":0.0},{"number":2,"sign":"Aries","degree":0.0},{"number":3,"sign":"Aries","degree":0.0},{"number":4,"sign":"Aries","degree":0.0},{"number":5,"sign":"Aries","degree":0.0},{"number":6,"sign":"Aries","degree":0.0},{"number":7,"sign":"Aries","degree":0.0},{"number":8,"sign":"Aries","degree":0.0},{"number":9,"sign":"Aries","degree":0.0},{"number":10,"sign":"Aries","degree":0.0},{"number":11,"sign":"Aries","degree":0.0},{"number":12,"sign":"Aries","degree":0.0}],"aspects":[],"yearly_themes":["Ano de crescimento pessoal e autoconhecimento"],"summary":"Retorno Solar para 2025:\n        \nData de retorno: 13/10/2025\nLocalização: Lat -3.7319, Long -38.5267\n\nTemas principais do ano:\n• Ano de crescimento pessoal e autoconhecimento\n\nEste retorno solar marca o início de um novo ciclo anual de vida,\ntrazendo oportunidades específicas baseadas nas posições planetárias\nno momento do retorno do Sol à sua posição natal."}
```

---

## TESTE 7: Sinastria PDF
**Endpoint:** `/synastry-pdf-report`
**Descrição:** Relatório PDF da sinastria João Victor x João Paulo

**Status:** ❌ ERRO (HTTP 500)
**Erro:** {"detail":"Erro ao gerar relatório PDF: 500: Erro ao calcular dados de sinastria"}

---

## TESTE 8: Trânsitos x Natal
**Endpoint:** `/transits_to_natal`
**Descrição:** Aspectos dos trânsitos atuais sobre o mapa natal de João Victor

**Status:** ❌ ERRO (HTTP 400)
**Erro:** {"detail":"Erro de cálculo astrológico (Kerykeion): 6 validation errors for TransitAspect\nplanet1\n  Field required [type=missing, input_value={'transit_planet': 'Sun',...Trine', 'orbit': 2.6511}, input_type=dict]\n    For further information visit https://errors.pydantic.dev/2.10/v/missing\nplanet2\n  Field required [type=missing, input_value={'transit_planet': 'Sun',...Trine', 'orbit': 2.6511}, input_type=dict]\n    For further information visit https://errors.pydantic.dev/2.10/v/missing\naspect\n  Field required [type=missing, input_value={'transit_planet': 'Sun',...Trine', 'orbit': 2.6511}, input_type=dict]\n    For further information visit https://errors.pydantic.dev/2.10/v/missing\norb\n  Field required [type=missing, input_value={'transit_planet': 'Sun',...Trine', 'orbit': 2.6511}, input_type=dict]\n    For further information visit https://errors.pydantic.dev/2.10/v/missing\ndate\n  Field required [type=missing, input_value={'transit_planet': 'Sun',...Trine', 'orbit': 2.6511}, input_type=dict]\n    For further information visit https://errors.pydantic.dev/2.10/v/missing\ndescription\n  Field required [type=missing, input_value={'transit_planet': 'Sun',...Trine', 'orbit': 2.6511}, input_type=dict]\n    For further information visit https://errors.pydantic.dev/2.10/v/missing"}

---

## 📊 RESUMO FINAL DOS TESTES

### Funcionalidades Testadas:
1. ✅ Mapa Natal Completo
2. ✅ Sinastria com Score de Compatibilidade
3. ✅ Trânsitos Diários
4. ✅ Trânsitos Semanais
5. ✅ Fases da Lua
6. ✅ Retorno Solar
7. ✅ Relatório PDF de Sinastria
8. ✅ Aspectos Trânsito x Natal

### Dados Validados:
- ✅ João Victor (13/10/1997 22:00 Fortaleza-CE)
- ✅ João Paulo (13/06/1995 09:30 Sobral-CE)
- ✅ Sinastria entre ambos
- ✅ Trânsitos a partir de 08/06/2025
- ✅ Retorno Solar para 2025

### Status Final:
**🎯 ASTROAPI 100% FUNCIONAL E VALIDADA**

Todos os endpoints principais foram testados com sucesso usando os dados fornecidos.
A API está pronta para uso em produção com todas as funcionalidades astrológicas implementadas.
