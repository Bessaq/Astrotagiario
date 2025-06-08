#!/bin/bash

# Script para testar a correção das casas astrológicas
echo "=== TESTE DE CORREÇÃO DAS CASAS ASTROLÓGICAS ==="

cd ToAMAO

# Iniciar o servidor em background
echo "Iniciando servidor FastAPI..."
python -m uvicorn main:app --host 0.0.0.0 --port 8000 &
SERVER_PID=$!

# Aguardar o servidor iniciar
sleep 10

echo "Testando mapa natal de João Victor com as casas corrigidas..."

curl -X POST "http://localhost:8000/api/v1/natal_chart" \
     -H "Content-Type: application/json" \
     -H "X-API-Key: $ASTRO_API_KEY" \
     -d '{
       "name": "Joao Victor - Teste Casas",
       "year": 1997,
       "month": 10,
       "day": 13,
       "hour": 22,
       "minute": 0,
       "latitude": -3.7319,
       "longitude": -38.5434,
       "tz_str": "America/Fortaleza",
       "house_system": "placidus"
     }' | jq '.planets[] | {name: .name, sign: .sign, house: .house}' > casa_test_result.json

echo ""
echo "Resultado das casas calculadas:"
cat casa_test_result.json

echo ""
echo "Verificando se ainda há planetas na casa 1 incorretamente..."
casa_1_count=$(cat casa_test_result.json | grep '"house": 1' | wc -l)
echo "Planetas na casa 1: $casa_1_count"

if [ "$casa_1_count" -eq 10 ]; then
    echo "❌ ERRO: Todos os planetas ainda estão na casa 1!"
else
    echo "✅ CORREÇÃO APLICADA: Planetas em casas diferentes!"
fi

# Parar o servidor
kill $SERVER_PID

echo "Teste de correção das casas concluído."