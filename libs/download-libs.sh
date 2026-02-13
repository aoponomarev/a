#!/bin/bash

echo "Загрузка библиотек..."

# Vue.js
echo "Загрузка Vue.js 3.4.0..."
curl -L -o vue/3.4.0/vue.global.js https://cdn.jsdelivr.net/npm/vue@3.4.0/dist/vue.global.js

# Chart.js
echo "Загрузка Chart.js 4.4.0..."
curl -L -o chartjs/4.4.0/chart.umd.js https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.js
curl -L -o chartjs/4.4.0/chart.min.js https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.min.js

# Vue Chart.js
echo "Загрузка Vue Chart.js 5.2.0..."
curl -L -o vue-chartjs/5.2.0/vue-chartjs.umd.js https://cdn.jsdelivr.net/npm/vue-chartjs@5.2.0/dist/vue-chartjs.umd.js

# Numeral.js
echo "Загрузка Numeral.js 2.0.6..."
curl -L -o numeral/2.0.6/numeral.min.js https://cdn.jsdelivr.net/npm/numeral@2.0.6/min/numeral.min.js

# VueUse
echo "Загрузка VueUse 10.7.0..."
curl -L -o vueuse/10.7.0/index.umd.js https://cdn.jsdelivr.net/npm/@vueuse/core@10.7.0/dist/index.umd.js

# Vue Draggable
echo "Загрузка Vue Draggable 4.1.0..."
curl -L -o vuedraggable/4.1.0/vuedraggable.umd.js https://cdn.jsdelivr.net/npm/vuedraggable@4.1.0/dist/vuedraggable.umd.js

# Date-fns
echo "Загрузка Date-fns 2.30.0..."
curl -L -o date-fns/2.30.0/index.umd.js https://cdn.jsdelivr.net/npm/date-fns@2.30.0/index.umd.js

echo "Загрузка завершена!"
