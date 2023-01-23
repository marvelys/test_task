#!/bin/bash
function get_title_api() #функция получения отстортированного списка слов из API
{
   echo "Введите адрес Api для получения данных:"
   read per1
   echo "Отсортированный список слов:"
   curl -s $per1 | jq .[:2] | jq -j '.[].title' |sed 's/ /\n/g'| grep -o "[[:alpha:]].*$"|sort -k 2
}

I=`dpkg -s jq 2>/dev/null | grep "ok installed"` #проверяем состояние пакета (dpkg) и ищем в выводе его статус (grep)
if [ -n "$I" ] #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo "jq установлена" #выводим результат
   get_title_api
else
   echo "jq не установлена в системе. Для работы скрипта необходимо установить утилиту jq"
   echo "Установить jq? [Y/N]"
   read answer
   echo $answer
   if [[ $answer =~ [yY] ]]
   then
      sudo apt-get install jq
      get_title_api
   else
      echo "jq не будет установлена"
   fi
fi
