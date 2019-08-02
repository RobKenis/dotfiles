extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1"                    ;;
            *.tar.gz)    tar xvzf "$1"                    ;;
            *.bz2)       bunzip2 "$1"                     ;;
            *.rar)       unrar x "$1"                     ;;
            *.gz)        gunzip "$1"                      ;;
            *.tar)       tar xvf "$1"                     ;;
            *.tbz2)      tar xvjf "$1"                    ;;
            *.tgz)       tar xvzf "$1"                    ;;
            *.zip)       unzip "$1"                       ;;
            *.ZIP)       unzip "$1"                       ;;
            *.pax)       cat "$1" | pax -r                ;;
            *.pax.Z)     uncompress "$1" —stdout | pax -r ;;
            *.Z)         uncompress "$1"                  ;;
            *.7z)        7z x "$1"                        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "extract: error: $1 is not valid"
    fi
}

function edig() {
  dig +nocmd +noall +answer "$1"
}

function bastionsshpf() {
  if [ $# -gt 1 ]; then
    SP=$(echo $1|awk -F: '{print $1}')
    DP=$(echo $1|awk -F: '{print $3}')
    DH=$(echo $1|awk -F: '{print $2}')
    BASTIONPORTS=$(ssh ssh.a51.be "tail -n +2 /proc/net/tcp|awk -F: '{print \$3}'|awk '{print \$1}'|while read line; do printf "%d\:" 0x\${line}; done; echo")
    echo "In use BASTIONPORTS: $BASTIONPORTS"
    FOUNDPORT=1
    until [ ${FOUNDPORT} == 0 ]; do
      export MYBASTIONPORT=$(echo $(( ( RANDOM % 32768 )  + 32767 )))
      echo $BASTIONPORTS| egrep -q "^${MYBASTIONPORT}|${MYBASTIONPORT}:" || FOUNDPORT=0
    done
    echo "MYBASTIONPORT is $MYBASTIONPORT"
    ssh -tL ${SP}:localhost:${MYBASTIONPORT} ssh.a51.be /opt/ssh -L ${MYBASTIONPORT}:${DH}:${DP} $2
  else
    echo "Need arguments: bastionsshpf <sourceport>:<forward-to-host>:<destinationport> <(user@)sshhost>"
    return 2
  fi;
}
