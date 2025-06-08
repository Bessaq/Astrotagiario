"""
Router para os endpoints de geração de gráficos SVG.

DEPRECIADO: Este módulo está depreciado. Use svg_chart_router_fixed em vez disso.
Este módulo contém os endpoints relacionados à geração de gráficos astrológicos em formato SVG.
"""
# DEPRECIADO: Use svg_chart_router_fixed em vez disso.
from fastapi import APIRouter, HTTPException, Depends
from fastapi.responses import Response
from typing import Dict, Optional, Any
from kerykeion import AstrologicalSubject, KerykeionChartSVG
import tempfile
import os
import base64

from app.models import SVGChartRequest
from app.utils.astro_helpers import create_subject # Changed import
from ..security import verify_api_key

router = APIRouter(
    prefix="/api/v1",
    tags=["SVG Chart"],
    dependencies=[Depends(verify_api_key)],
)

def get_svg_content(chart: Any, temp_file: str) -> str:
    """
    Tenta obter o conteúdo SVG do gráfico de várias maneiras possíveis.
    
    Args:
        chart (Any): O objeto do gráfico
        temp_file (str): Caminho para o arquivo temporário
        
    Returns:
        str: Conteúdo SVG
        
    Raises:
        Exception: Se não for possível obter o conteúdo SVG
    """
    # Tentar métodos diretos primeiro
    if hasattr(chart, 'svg_string') and getattr(chart, 'svg_string'):
        return getattr(chart, 'svg_string')
    if hasattr(chart, 'svg') and getattr(chart, 'svg'):
        return getattr(chart, 'svg')
    if hasattr(chart, 'get_svg_string') and callable(getattr(chart, 'get_svg_string')):
        return getattr(chart, 'get_svg_string')()
    if hasattr(chart, 'get_svg') and callable(getattr(chart, 'get_svg')):
        return getattr(chart, 'get_svg')()
    if hasattr(chart, 'makeTemplate') and callable(getattr(chart, 'makeTemplate')):
        return getattr(chart, 'makeTemplate')()
        
    # Se nenhum método direto funcionar, tentar ler o arquivo
    try:
        if os.path.exists(temp_file):
            with open(temp_file, 'r', encoding='utf-8') as f:
                content = f.read()
                if content:
                    return content
    except Exception as e:
        raise Exception(f"Erro ao ler arquivo SVG: {str(e)}")
        
    raise Exception("Não foi possível obter o conteúdo SVG por nenhum método disponível")

@router.post("/svg_chart", 
    response_class=Response,
    responses={
        200: {"content": {"image/svg+xml": {}}, "description": "Retorna o gráfico SVG diretamente."},
        422: {"description": "Erro de validação nos dados de entrada."},
        500: {"description": "Erro interno ao gerar o gráfico."}
    })
async def generate_svg_chart(data: SVGChartRequest):
    """Gera um gráfico SVG para um mapa natal, trânsito ou combinação."""
    try:
        natal_req = data.natal_chart
            
        natal_subject = create_subject(
            natal_req,
            natal_req.name or "Natal Chart"
        )
        
        
        # Criar diretório temporário para o SVG
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_file = os.path.join(temp_dir, "chart.svg")
            
            # Configurar e gerar o gráfico
            chart_params = {
                "new_output_directory": temp_dir,
                "filename": "chart.svg"
            }
            
            # Adicionar configurações de tema
            if data.theme == "dark":
                chart_params["black_bg"] = True
            
            # Criar o gráfico com base no tipo
            if data.chart_type == "natal":
                chart = KerykeionChartSVG(natal_subject, **chart_params)
            else:
                raise HTTPException(
                    status_code=422,
                    detail="Tipo de gráfico inválido. Apenas 'natal' é suportado."
                )
            
            
            # Gerar SVG
            chart.makeSVG()
            
            try:
                svg_content = get_svg_content(chart, temp_file)
            except Exception as e:
                raise HTTPException(status_code=500, detail=f"Erro ao obter conteúdo SVG: {str(e)}")
            
            return Response(
                content=svg_content,
                media_type="image/svg+xml",
                headers={
                    "Content-Disposition": f"inline; filename=chart_{natal_req.name or 'astrology'}.svg"
                }
            )
            
    except HTTPException as http_exc:
        raise http_exc
    except Exception as e:
        print(f"Erro detalhado ao gerar SVG: {type(e).__name__}: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Erro interno ao gerar gráfico SVG: {str(e)}")

@router.post("/svg_chart_base64", 
    response_model=Dict[str, str],
    summary="Gera gráfico SVG em Base64",
    description="Gera um gráfico SVG e retorna como string base64, útil para incorporação em aplicações web.")
async def generate_svg_chart_base64(data: SVGChartRequest):
    """
    Gera um gráfico SVG e retorna como string base64.
    """
    try:
        svg_response = await generate_svg_chart(data)
        if svg_response.status_code != 200:
            raise HTTPException(status_code=svg_response.status_code, detail="Falha ao gerar SVG base.")
            
        svg_content_bytes = svg_response.body
        base64_svg = base64.b64encode(svg_content_bytes).decode("utf-8")
        
        return {
            "svg_base64": base64_svg,
            "data_uri": f"data:image/svg+xml;base64,{base64_svg}"
        }
    except HTTPException as http_exc:
        raise http_exc
    except Exception as e:
        print(f"Erro detalhado ao gerar SVG base64: {type(e).__name__}: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail=f"Erro interno ao gerar gráfico SVG em base64: {str(e)}"
        )

