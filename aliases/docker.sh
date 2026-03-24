alias dk=docker
alias dc=docker-compose
alias dkr='docker run -it --rm'
alias dke='docker exec -it'
alias dip='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}"'
alias dk-host-shell='docker run -it --rm --privileged --pid=host justincormack/nsenter1'
alias dkl='docker logs -f --tail=100'
