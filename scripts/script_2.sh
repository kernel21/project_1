#!/usr/bin/env bash
#!/bin/bash
# рекурсивно синхронизируем каталог с генерированными файлами, синхронизация в режиме archive с сохранением атрибутов и прав. Так же используется сжатие.
# --delete указывает, что в 10.4.1.246:/var/devops_lab удаляются файлы, отсутвующие в /root/tmp/devops_lab/, -v - подробный режим.
# предварительно через ssh-keygen -t rsa создан ключ и скопирован на 10.4.1.246 через ssh-copy-id -i
rsync -azv --delete /root/tmp/devops_lab/ 10.4.1.246:/var/devops_lab
# через crontab -e добавлено задание для планировщика
# 00 05 * * * /bin/bash /root/script_2.sh