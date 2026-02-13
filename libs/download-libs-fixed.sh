#!/bin/bash

echo "Загрузка библиотек (исправленные URL)..."

# Vue.js - уже загружен, пропускаем
echo "Vue.js уже загружен"

# Chart.js - уже загружен, пропускаем
echo "Chart.js уже загружен"

# Vue Chart.js - используем альтернативный источник
echo "Загрузка Vue Chart.js 5.2.0..."
rm -f vue-chartjs/5.2.0/vue-chartjs.umd.js
curl -L -o vue-chartjs/5.2.0/vue-chartjs.umd.js https://unpkg.com/vue-chartjs@5.2.0/dist/vue-chartjs.umd.js || echo "Vue Chart.js: UMD сборка недоступна, требуется сборка из исходников"

# Numeral.js - уже загружен, пропускаем
echo "Numeral.js уже загружен"

# VueUse - используем unpkg или создаём обёртку
echo "Загрузка VueUse 10.7.0..."
rm -f vueuse/10.7.0/index.umd.js
curl -L -o vueuse/10.7.0/index.umd.js https://unpkg.com/@vueuse/core@10.7.0/dist/index.umd.js || echo "VueUse: UMD сборка недоступна, требуется сборка из исходников"

# Vue Draggable - уже загружен, пропускаем
echo "Vue Draggable уже загружен"

# Date-fns - не имеет UMD сборки, создаём заглушку с инструкцией
echo "Date-fns не имеет UMD сборки..."
rm -f date-fns/2.30.0/index.umd.js
cat > date-fns/2.30.0/README.md << 'INNEREOF'
# Date-fns 2.30.0

Date-fns не имеет UMD сборки, это ESM-only библиотека.

Альтернативы:
1. Использовать через динамический import (если поддерживается)
2. Использовать альтернативную библиотеку с UMD (moment.js, dayjs)
3. Собрать UMD версию самостоятельно

Для использования в проекте без сборки рекомендуется использовать dayjs:
https://cdn.jsdelivr.net/npm/dayjs@1.11.10/dayjs.min.js
INNEREOF

echo "Загрузка завершена!"
