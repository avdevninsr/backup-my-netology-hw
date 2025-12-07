#!/bin/bash

sudo su
echo "$(date +%Y-%m-%d_%H:%M:%S) - Starting the backup of the home directory" >> /var/log/backup.log

# Команда rsync. Cтандартный вывод - в /dev/null, ошибки - в лог.
rsync -ahavP --include '${HOME}' --exclude='.*' /home/tankist /tmp/backup
rsync -ahavP --checksum --exclude=".*" /home/tankist/ /tmp/backup/ > /dev/null 2>> /var/log/backup.log

# Проверка кода завершения rsync и запись лога
if [ $? -eq 0 ]; then
    echo "[$(date)] Резервное копирование успешно выполнено" >> /var/log/backup.log
else
    echo "[$(date)] Ошибка при выполнении резервного копирования" >> /var/log/backup.log
fi
