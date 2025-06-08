# 🔧 PLANO DE CORREÇÕES TOAMAO - IMPLEMENTAÇÃO PRÁTICA

**Objetivo:** Corrigir todos os bugs identificados e preparar integração com Evo.ai

---

## 📋 CHECKLIST DE CORREÇÕES

### ✅ **FASE 1: CORREÇÕES CRÍTICAS**

#### 1. **INCLUIR ROUTER SVG COMBINADO**

**Arquivo:** `main.py`  
**Ação:** Adicionar import e include

```python
# ANTES (linha 2):
from app.routers import natal_chart_router, transit_router, svg_chart_router, webhook_router

# DEPOIS:
from app.routers import natal_chart_router, transit_router, svg_chart_router, svg_combined_chart_router, webhook_router

# ANTES (linha 19):
app.include_router(webhook_router.router)

# DEPOIS:
app.include_router(webhook_router.router)
app.include_router(svg_combined_chart_router.router)  # ⬅️ ADICIONAR
```

#### 2. **CORRIGIR REQUIREMENTS.TXT**

**Arquivo:** `requirements.txt`  
**Ação:** Adicionar dependência ausente

```txt
fastapi
uvicorn[standard]
python-dotenv
kerykeion
svgwrite
```

#### 3. **LIMPAR CÓDIGO DUPLICADO**

**Arquivo:** `app/models.py`  
**Ação:** Remover código duplicado (linhas 95-200)

```python
# MANTER APENAS OS MODELOS DE DADOS:
# - Classes Enum
# - Modelos BaseModel  
# - Constantes

# REMOVER:
# - Código de routers
# - Imports específicos de routers
# - Lógica de processamento
```

#### 4. **CORRIGIR ENDPOINT COMBINED NO SVG_CHART_ROUTER**

**Arquivo:** `app/routers/svg_chart_router.py`  
**Ação:** Desabilitar chart_type "combined" ou redirecionar

```python
# OPÇÃO 1: Desabilitar combined
elif data.chart_type == "combined":
    raise ValueError("Use o endpoint /svg_combined_chart para gráficos combinados")

# OPÇÃO 2: Redirecionar para implementação personalizada
elif data.chart_type == "combined" and transit_subject:
    from app.utils.svg_combined_chart import generate_combined_chart
    temp_dir = Path("/tmp/astro_svg")
    temp_dir.mkdir(parents=True, exist_ok=True)
    svg_path = generate_combined_chart(natal_subject, transit_subject, temp_dir)
    
    with open(svg_path, 'r') as svg_file:
        svg_content = svg_file.read()
    
    return Response(
        content=svg_content,
        media_type="image/svg+xml"
    )
```

---

### ✅ **FASE 2: MELHORIAS**

#### 5. **IMPLEMENTAR ENDPOINT DE SINASTRIA**

**Arquivo:** `app/routers/synastry_router.py` (NOVO)

```python
from fastapi import APIRouter, HTTPException, Depends
from app.models import NatalChartRequest
from app.security import verify_api_key
from app.utils.astro_helpers import create_subject
from typing import List, Dict
from pydantic import BaseModel

router = APIRouter(prefix="/api/v1", tags=["Synastry"], dependencies=[Depends(verify_api_key)])

class SynastryRequest(BaseModel):
    person1: NatalChartRequest
    person2: NatalChartRequest

class SynastryAspect(BaseModel):
    p1_planet: str
    p2_planet: str
    aspect_name: str
    orb: float
    aspect_type: str  # "harmonic", "tense", "neutral"

class SynastryResponse(BaseModel):
    person1_data: NatalChartRequest
    person2_data: NatalChartRequest
    aspects: List[SynastryAspect]
    compatibility_score: float

@router.post("/synastry", response_model=SynastryResponse)
async def calculate_synastry(request: SynastryRequest):
    """Calcula aspectos entre dois mapas natais (sinastria)"""
    try:
        subject1 = create_subject(request.person1, "Person 1")
        subject2 = create_subject(request.person2, "Person 2")
        
        # Implementar lógica de sinastria
        aspects = calculate_inter_chart_aspects(subject1, subject2)
        compatibility = calculate_compatibility_score(aspects)
        
        return SynastryResponse(
            person1_data=request.person1,
            person2_data=request.person2,
            aspects=aspects,
            compatibility_score=compatibility
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
```

#### 6. **MELHORAR TRATAMENTO DE ERROS**

**Arquivo:** `app/exceptions.py`  
**Ação:** Adicionar mais handlers específicos

```python
class KerykeionCalculationError(AstroAPIException):
    """Erro específico para cálculos astrológicos"""
    pass

class SVGGenerationError(AstroAPIException):
    """Erro específico para geração de SVG"""
    pass

@app.exception_handler(KerykeionCalculationError)
async def kerykeion_exception_handler(request: Request, exc: KerykeionCalculationError):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "detail": exc.detail,
            "error_type": "astrological_calculation_error"
        }
    )
```

---

### ✅ **FASE 3: INTEGRAÇÃO EVO.AI**

#### 7. **CRIAR CUSTOM TOOLS JSON**

**Arquivo:** `evo_ai_astro_tools.json` (NOVO)

```json
{
  "custom_tools": [
    {
      "name": "astro-natal-chart",
      "description": "Calcula mapa natal completo com planetas, casas e aspectos",
      "endpoint": {
        "method": "POST",
        "url": "https://toamao-production.up.railway.app/api/v1/natal_chart",
        "authentication": {
          "type": "apiKey",
          "header": "X-API-KEY",
          "value": "{{env.ASTRO_API_KEY}}"
        }
      },
      "parameters": [
        {
          "name": "name",
          "type": "string",
          "description": "Nome da pessoa",
          "required": false
        },
        {
          "name": "year",
          "type": "integer",
          "description": "Ano de nascimento",
          "required": true
        },
        {
          "name": "month",
          "type": "integer",
          "description": "Mês de nascimento (1-12)",
          "required": true
        },
        {
          "name": "day",
          "type": "integer", 
          "description": "Dia de nascimento",
          "required": true
        },
        {
          "name": "hour",
          "type": "integer",
          "description": "Hora de nascimento (0-23)",
          "required": true
        },
        {
          "name": "minute",
          "type": "integer",
          "description": "Minuto de nascimento (0-59)",
          "required": true
        },
        {
          "name": "latitude",
          "type": "number",
          "description": "Latitude do local de nascimento",
          "required": true
        },
        {
          "name": "longitude",
          "type": "number",
          "description": "Longitude do local de nascimento", 
          "required": true
        },
        {
          "name": "tz_str",
          "type": "string",
          "description": "Timezone (ex: America/Fortaleza)",
          "required": true
        }
      ]
    },
    {
      "name": "astro-transits-to-natal",
      "description": "Calcula aspectos entre trânsitos atuais e mapa natal",
      "endpoint": {
        "method": "POST",
        "url": "https://toamao-production.up.railway.app/api/v1/transits_to_natal",
        "authentication": {
          "type": "apiKey",
          "header": "X-API-KEY",
          "value": "{{env.ASTRO_API_KEY}}"
        }
      }
    },
    {
      "name": "astro-synastry",
      "description": "Calcula compatibilidade entre dois mapas natais",
      "endpoint": {
        "method": "POST",
        "url": "https://toamao-production.up.railway.app/api/v1/synastry",
        "authentication": {
          "type": "apiKey",
          "header": "X-API-KEY",
          "value": "{{env.ASTRO_API_KEY}}"
        }
      }
    },
    {
      "name": "astro-chart-svg",
      "description": "Gera gráfico SVG do mapa natal ou combinado",
      "endpoint": {
        "method": "POST",
        "url": "https://toamao-production.up.railway.app/api/v1/svg_chart",
        "authentication": {
          "type": "apiKey",
          "header": "X-API-KEY",
          "value": "{{env.ASTRO_API_KEY}}"
        }
      }
    }
  ]
}
```

#### 8. **WORKFLOW EXAMPLES PARA EVO.AI**

**Arquivo:** `evo_ai_astro_workflows.json` (NOVO)

```json
{
  "agents": [
    {
      "name": "AstrologiaPersonalizada",
      "description": "Agente especializado em cálculos astrológicos personalizados",
      "type": "llm",
      "role": "Astrólogo Digital",
      "goal": "Fornecer análises astrológicas precisas e personalizadas",
      "instruction": "Você é um astrólogo experiente. Use as ferramentas disponíveis para calcular mapas natais, trânsitos e sinastrias. {{user_input}}",
      "config": {
        "output_key": "astrological_analysis",
        "custom_tools": [
          "astro-natal-chart",
          "astro-transits-to-natal", 
          "astro-synastry",
          "astro-chart-svg"
        ]
      }
    },
    {
      "name": "TransitosAutomaticos",
      "description": "Monitor automático de trânsitos importantes",
      "type": "task",
      "config": {
        "trigger_type": "cron",
        "schedule": "0 6 * * *",
        "actions": [
          {
            "type": "calculate_transits",
            "tool": "astro-transits-to-natal"
          },
          {
            "type": "notify_important_aspects",
            "condition": "orb < 2.0"
          }
        ]
      }
    }
  ]
}
```

---

## 📋 ARQUIVOS A MODIFICAR

### **MODIFICAÇÕES NECESSÁRIAS:**

1. ✅ `main.py` - Incluir router SVG combinado
2. ✅ `requirements.txt` - Adicionar svgwrite
3. ✅ `app/models.py` - Remover código duplicado
4. ✅ `app/routers/svg_chart_router.py` - Corrigir combined chart
5. ✅ `app/exceptions.py` - Melhorar handlers

### **ARQUIVOS NOVOS:**

6. ✅ `app/routers/synastry_router.py` - Endpoint de sinastria
7. ✅ `evo_ai_astro_tools.json` - Custom tools
8. ✅ `evo_ai_astro_workflows.json` - Workflows exemplo

### **ARQUIVOS FUNCIONAIS (NÃO MODIFICAR):**

- ✅ `app/routers/natal_chart_router.py`
- ✅ `app/routers/transit_router.py`
- ✅ `app/routers/svg_combined_chart_router.py`
- ✅ `app/utils/astro_helpers.py`
- ✅ `app/utils/svg_combined_chart.py`
- ✅ `app/security.py`

---

## 🧪 PLANO DE TESTES

### **TESTES APÓS CADA CORREÇÃO:**

1. **Router SVG Combinado:**
```bash
curl -X POST https://toamao-production.up.railway.app/api/v1/svg_combined_chart \
  -H "X-API-KEY: testapikey" \
  -H "Content-Type: application/json" \
  -d @combined_chart_request.json
```

2. **Endpoint Sinastria:**
```bash
curl -X POST https://toamao-production.up.railway.app/api/v1/synastry \
  -H "X-API-KEY: testapikey" \
  -H "Content-Type: application/json" \
  -d @synastry_request.json
```

3. **Integração Evo.ai:**
- Importar custom tools
- Criar agente teste
- Executar workflow

---

## ⏱️ ESTIMATIVA DE TEMPO

- **Fase 1 (Correções Críticas):** 1-2 horas
- **Fase 2 (Melhorias):** 2-3 horas  
- **Fase 3 (Integração Evo.ai):** 1-2 horas
- **Testes e Documentação:** 1 hora

**Total:** 5-8 horas de desenvolvimento

---

## 🎯 RESULTADO ESPERADO

Após implementar todas as correções:

✅ **API 100% funcional** sem erros  
✅ **Todos os endpoints disponíveis** e testados  
✅ **Sinastria automática** implementada  
✅ **Custom Tools prontas** para Evo.ai  
✅ **Workflows exemplo** configurados  
✅ **Documentação atualizada**  

**Status Final:** Pronto para produção e integração completa com Evo.ai! 🚀

---

*Plano criado em 08/06/2025 - Ready for implementation!*