#!/bin/bash

# Ejecutar pruebas con cobertura
flutter test --pub --coverage

# Remover carpetas específicas de la cobertura
dart run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r 'data'
dart run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r 'helpers'
dart run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r 'entities'
dart run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r 'models'
dart run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r 'repositories'

format_coverage --lcov --check-ignore  --in=coverage --out=coverage.lcov --packages=.packages --report-on=lib

# Generar reporte HTML
genhtml coverage/lcov.info -o coverage/html

# Abrir el reporte en el navegador (Windows)
start coverage/html/index.html