#!/bin/sh -eux
journalctl --vacuum-size=500M  # оставим только 500Mb логов journald
docker volume prune  # удаляем все volume, не связанные с контейнерами
docker image prune -a  # удаляем все image, не связанные с контейнерами
docker buildx prune  # удаляем кэш buildx
docker container prune --filter "until=2160h"  # удаляем остановленные более 90 дней назад контейнеры
docker images | grep "" | awk '{print $3}' | xargs docker rmi -f  # удаляем "висячие" image
