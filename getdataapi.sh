#!/bin/bash
function get_title_api()
{
   echo "Введите адрес Api для получения данных:"
   read per1
   #echo $per1
   #echo "Ссылка принята"
   echo "Отсортированный список слов:"
   curl -s $per1 | jq .[:2] | jq -j '.[].title' |sed 's/ /\n/g'| grep -o "[[:alpha:]].*$"|sort -k 2
}

I=`dpkg -s jq 2>/dev/null | grep "ok installed"` #проверяем состояние пакета (dpkg) и ищем в выводе его статус (grep)
if [ -n "$I" ] #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo "jq installed" #выводим результат
   get_title_api
else
   echo "jq не установлена необходимо установить утилиту jq"
   echo "Установить jq? [Y/N]"
   read answer
   echo $answer
   if [[ $answer =~ [yY] ]]
   then
      sudo apt-get install jq
      get_title_api
   else
      echo "jq не будет установлен"
   fi
fi


