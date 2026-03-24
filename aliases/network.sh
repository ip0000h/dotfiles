alias netconn="watch -n 1 'netstat -antup | grep ESTABLISHED'"

resolve () {
    local host="$1"
    echo $(dig @1.1.1.1 $host | grep -A2 ANS | grep -i click | awk '{print $5}')
}
