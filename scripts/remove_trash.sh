#!/bin/sh -eux
journalctl --vacuum-size=500M  # оставим только 500Mb логов journald
docker container prune -f --filter "until=2160h"  # удаляем остановленные более 90 дней назад контейнеры
docker image prune -f  # удаляем dangling images
docker volume prune -f  # удаляем все volume, не связанные с контейнерами
docker buildx prune -f  # удаляем кэш buildx
