#!/bin/bash
yes | sudo elma365ctl dump > /home/elma/log.txt
backup_folder="/backup"  
# Рассчитываем текущую дату, 6-месяцев и неделю назад 
current_date=$(date +%s)
one_weeks_ago=$(date -d "weeks ago" +%s)
six_months_ago=$(date -d "6 months ago" +%s)
# Перебираем файлы в папке с бэкапами
for file in "$backup_folder"/*; do
  # Получаем дату файла из его имени
  filename=$(basename "$file")  
  date_part=$(echo "$filename" | cut -b 1-10 )
  echo $date_part  
  file_date=$(date -d "${date_part//.//}" +%s) 
  # Проверяем, старше ли файл двух недель и не является ли датой 01 
  if [[ $file_date -lt $one_weeks_ago ]] &&  [[ "${date_part:8:9}" != "01" ]] ; then     
    rm -rf "$file"
    echo "Удален файл: $file"
  elif [[ $file_date -lt $six_months_ago ]] &&  [[ "${date_part:8:9}" = "01" ]] && [[ "${date_part:5:9}" != "01.01" ]] ; then
    rm -rf "$file"
    echo "Удален файл: $file"    
  fi
done
