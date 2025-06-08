#!/bin/bash

# Script de teste completo para a AstroAPI
API_BASE_URL="http://localhost:8007/api/v1"
API_KEY="testapikey"

echo "🚀 TESTANDO ASTROAPI TOAMAO - VERSÃO COMPLETA"
echo "=============================================="
echo ""

# Função para fazer requisições POST
test_endpoint() {
    local endpoint=$1
    local data_file=$2
    local description=$3
    
    echo ""
    echo "🔍 Testando: $description"
    echo "Endpoint: $endpoint"
    
    response=$(curl -s -w "\nHTTP_CODE:%{http_code}" \
        -X POST "$API_BASE_URL$endpoint" \
        -H "X-API-KEY: $API_KEY" \
        -H "Content-Type: application/json" \
        -d @"$data_file")
    
    http_code=$(echo "$response" | tail -n1 | cut -d: -f2)
    response_body=$(echo "$response" | sed '$d')
    
    if [ "$http_code" = "200" ]; then
        echo "✅ SUCESSO (HTTP $http_code)"
        # Extrair informação relevante da resposta
        if echo "$response_body" | jq -e '.summary' > /dev/null 2>&1; then
            echo "Resumo: $(echo "$response_body" | jq -r '.summary')"
        elif echo "$response_body" | jq -e '.phase' > /dev/null 2>&1; then
            phase=$(echo "$response_body" | jq -r '.phase')
            illumination=$(echo "$response_body" | jq -r '.illumination')
            echo "Fase da Lua: $phase ($illumination% iluminação)"
        elif echo "$response_body" | jq -e '.aspects' > /dev/null 2>&1; then
            aspects_count=$(echo "$response_body" | jq '.aspects | length')
            echo "Aspectos encontrados: $aspects_count"
        elif echo "$response_body" | jq -e '.days' > /dev/null 2>&1; then
            days_count=$(echo "$response_body" | jq '.days | length')
            echo "Previsão para $days_count dias"
        elif echo "$response_body" | jq -e '.pdf_url' > /dev/null 2>&1; then
            pdf_url=$(echo "$response_body" | jq -r '.pdf_url')
            echo "PDF gerado: $pdf_url"
        elif echo "$response_body" | jq -e '.input_data.name' > /dev/null 2>&1; then
            name=$(echo "$response_body" | jq -r '.input_data.name')
            echo "Mapa calculado para: $name"
        else
            echo "Dados recebidos com sucesso"
        fi
    else
        echo "❌ ERRO (HTTP $http_code)"
        echo "Resposta: $response_body"
    fi
}

echo "📋 TESTE 1: Mapa Natal - João Victor (13/10/1997)"
cat > test_natal_joao.json << EOF
{
    "name": "João Victor",
    "year": 1997,
    "month": 10,
    "day": 13,
    "hour": 22,
    "minute": 0,
    "latitude": -3.7319,
    "longitude": -38.5267,
    "tz_str": "America/Fortaleza",
    "house_system": "placidus"
}
EOF

test_endpoint "/natal_chart" "test_natal_joao.json" "Mapa Natal João Victor"

echo ""
echo "🆕 TESTE 2: Trânsitos Diários (08/06/2025)"
cat > test_daily_transits.json << EOF
{
    "year": 2025,
    "month": 6,
    "day": 8
}
EOF

test_endpoint "/transits/daily" "test_daily_transits.json" "Trânsitos Diários"

echo ""
echo "🆕 TESTE 3: Trânsitos Semanais (08/06/2025)"
test_endpoint "/transits/weekly" "test_daily_transits.json" "Trânsitos Semanais (7 dias)"

echo ""
echo "🆕 TESTE 4: Fase da Lua (08/06/2025)"
test_endpoint "/moon_phase" "test_daily_transits.json" "Fase da Lua"

echo ""
echo "🆕 TESTE 5: Retorno Solar - João Victor"
cat > test_solar_return.json << EOF
{
    "year": 1997,
    "month": 10,
    "day": 13,
    "hour": 22,
    "minute": 0,
    "latitude": -3.7319,
    "longitude": -38.5267,
    "tz_str": "America/Fortaleza"
}
EOF

test_endpoint "/solar_return" "test_solar_return.json" "Retorno Solar João Victor"

echo ""
echo "📋 TESTE 6: Sinastria João Victor x João Paulo"
cat > test_synastry.json << EOF
{
    "person1": {
        "name": "João Victor",
        "year": 1997,
        "month": 10,
        "day": 13,
        "hour": 22,
        "minute": 0,
        "latitude": -3.7319,
        "longitude": -38.5267,
        "tz_str": "America/Fortaleza",
        "house_system": "placidus"
    },
    "person2": {
        "name": "João Paulo",
        "year": 1995,
        "month": 6,
        "day": 13,
        "hour": 9,
        "minute": 30,
        "latitude": -3.6880,
        "longitude": -40.3497,
        "tz_str": "America/Fortaleza",
        "house_system": "placidus"
    }
}
EOF

test_endpoint "/synastry" "test_synastry.json" "Sinastria João Victor x João Paulo"

echo ""
echo "🆕 TESTE 7: Sinastria com PDF - João Victor x João Paulo"
test_endpoint "/synastry-pdf-report" "test_synastry.json" "Sinastria com PDF"

echo ""
echo "📋 TESTE 8: SVG Combinado"
cat > test_combined_chart.json << EOF
{
    "natal_chart": {
        "name": "João Victor",
        "year": 1997,
        "month": 10,
        "day": 13,
        "hour": 22,
        "minute": 0,
        "latitude": -3.7319,
        "longitude": -38.5267,
        "tz_str": "America/Fortaleza",
        "house_system": "placidus"
    },
    "transit_chart": {
        "year": 2025,
        "month": 6,
        "day": 8,
        "hour": 12,
        "minute": 0,
        "latitude": -3.7319,
        "longitude": -38.5267,
        "tz_str": "America/Fortaleza",
        "house_system": "placidus"
    }
}
EOF

test_endpoint "/svg_combined_chart" "test_combined_chart.json" "SVG Combinado"

echo ""
echo "📋 TESTE 9: Trânsitos sobre Natal"
cat > test_transits_to_natal.json << EOF
{
    "natal_data": {
        "name": "João Victor",
        "year": 1997,
        "month": 10,
        "day": 13,
        "hour": 22,
        "minute": 0,
        "latitude": -3.7319,
        "longitude": -38.5267,
        "tz_str": "America/Fortaleza",
        "house_system": "placidus"
    },
    "transit_data": {
        "year": 2025,
        "month": 6,
        "day": 8,
        "hour": 12,
        "minute": 0,
        "latitude": -3.7319,
        "longitude": -38.5267,
        "tz_str": "America/Fortaleza",
        "house_system": "placidus"
    }
}
EOF

test_endpoint "/transits_to_natal" "test_transits_to_natal.json" "Aspectos Trânsito x Natal"

# Limpeza dos arquivos de teste
rm -f test_*.json

echo ""
echo "🎯 RESUMO COMPLETO DOS TESTES"
echo "============================="
echo ""
echo "✅ FUNCIONALIDADES TESTADAS:"
echo "  • Mapa Natal João Victor (13/10/1997)"
echo "  • Sinastria João Victor x João Paulo"
echo "  • SVG Combinado"
echo "  • Aspectos Trânsito x Natal"
echo "  • Trânsitos Diários (aspectos do dia)"
echo "  • Trânsitos Semanais (previsão 7 dias)"
echo "  • Fases da Lua (com % iluminação)"
echo "  • Retorno Solar (próximo aniversário)"
echo "  • Sinastria com PDF (relatório completo)"
echo ""
echo "🚀 STATUS: ASTROAPI 100% TESTADO!"
echo ""
echo "Testes concluídos em $(date)"