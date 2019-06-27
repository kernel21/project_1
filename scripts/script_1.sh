#!/usr/bin/env bash
# указывем каталог с файлами для геренации
archdir="/root/tmp/devops_lab"
# использование для сжатия многопоточного архиватора lbzip, полностью совместимого с bzip2, apt install lbzip
options="-c --use-compress-program=lbzip2 -f"
# дата в формате ГГ-ММ-ДД
date=`date +%y-%m-%d`
# колмчество файлов для герерации
files=20
# срок хранения файлов
keep_backups_days=7

# подчищаем старые файлы, время создание которых больше 7 дней
find $archdir -type f -mtime +$keep_backups_days -exec rm -f {} \;

# создаем файлы в цикле
for (( i=1; i <= $files; i++ )) do
# заполняем файл из /dev/urandom по 1М в 10 проходов (файл размером 10М)
dd if=/dev/urandom of=$archdir/"$date"_"$i" bs=1M count=10
# архивируем полученный файл
cd $archdir && tar $options $archdir/"$date"_"$i".tar.bz2 "$date"_"$i"
# удаляем исходный файл
rm "$date"_"$i"
done
# через crontab -e добавлено задание для планировщика
# 00 04 * * * /bin/bash /root/script_1.sh