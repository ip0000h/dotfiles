alias dk=docker
alias dc=docker-compose
alias dkr='docker run -it --rm'
alias dke='docker exec -it'
alias dip='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}"'
alias dkl='docker logs -f --tail=100'
