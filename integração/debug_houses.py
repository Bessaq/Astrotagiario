#!/usr/bin/env python3
"""
Script de debug para verificar como as casas estão sendo retornadas pelo Kerykeion
"""
from kerykeion import AstrologicalSubject

# Testar com os dados do João Victor
subject = AstrologicalSubject(
    name="Joao Victor",
    year=1997,
    month=10,
    day=13,
    hour=22,
    minute=0,
    lng=-38.5434,  # Fortaleza-CE
    lat=-3.7319,
    tz_str="America/Fortaleza",
    houses_system_identifier="P"
)

print("=== DEBUG DAS CASAS ===")
print(f"Subject criado: {subject.name}")

# Verificar como os planetas reportam suas casas
planets = ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto']

for planet_name in planets:
    planet = getattr(subject, planet_name)
    print(f"\n--- {planet_name.upper()} ---")
    print(f"Nome: {planet.name}")
    print(f"Posição: {planet.position}°")
    print(f"Signo: {planet.sign}")
    
    # Verificar todos os atributos relacionados a casa
    print("Atributos relacionados à casa:")
    for attr in dir(planet):
        if 'house' in attr.lower():
            try:
                value = getattr(planet, attr)
                print(f"  {attr}: {value}")
            except:
                pass
    
    # Verificar se há um método específico para casa
    if hasattr(planet, 'house'):
        print(f"planet.house: {planet.house}")
        print(f"type(planet.house): {type(planet.house)}")
    
print("\n=== CASAS DIRETAS ===")
# Verificar as casas diretas
for i in range(1, 13):
    house_names = ['first_house', 'second_house', 'third_house', 'fourth_house',
                   'fifth_house', 'sixth_house', 'seventh_house', 'eighth_house',
                   'ninth_house', 'tenth_house', 'eleventh_house', 'twelfth_house']
    house_name = house_names[i-1]
    house = getattr(subject, house_name)
    print(f"Casa {i} ({house_name}): {house.position}° {house.sign}")