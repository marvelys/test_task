#!/bin/bash
I=`dpkg -s jq | grep "Status" ` #проверяем состояние пакета (dpkg) и ищем в выводе его статус (grep)
if [ -n "$I" ] #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo $1" installed" #выводим результат
else
   echo $1" not installed"
fi
