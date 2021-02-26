function git() {
  GIT=$(which git)

  for i do
    lastArgument=$i # last argument can be the directory or the repository url
  done

  ${GIT} $@

  if [[ $? -eq 0 ]] # only show prompt if git command was successful
  then
    if [[ "$1" = "init" || "$1" = "clone" ]]
    then
      if [[ -d "$lastArgument" ]]
      then
        # it was the directory argument, cd it
        pushd $lastArgument
      else
        # no directory given, parse it from repository url
        pushd $(echo $lastArgument | awk -F/ '{ print $NF }' | rev | sed 's/tig.//' | rev)
      fi
      git-email-prompt.sh
      popd
    fi
  else
    # return the exit code of the failed git command call
    return $?
  fi
}

function ls() {
  export WS="${HOME}/ws/$(date '+%Y%m%d')"
  /bin/ls -F $@  # full-path to avoid recursion
}

# --- "virtualenv" bindings

function mkvirtualenv() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: ${FUNCNAME[0]} <venv name>"
        return;
    fi

    if [[ -z "${VENV_HOME}" ]]; then
        echo "VENV_HOME undefined"
        return;
    fi

    if [[ -z "$(which python3)" ]]; then
        echo "python3 not found"
        return;
    fi

    python3 -m venv ${VENV_HOME}/${1}
    source ${VENV_HOME}/${1}/bin/activate
}

function lsvirtualenv() {
    if [[ -z "${VENV_HOME}" ]]; then
        echo "VENV_HOME undefined"
        return;
    fi

    /bin/ls ${VENV_HOME}
}

function rmvirtualenv() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: ${FUNCNAME[0]} <venv name>"
        return;
    fi

    if [[ -z "${VENV_HOME}" ]]; then
        echo "VENV_HOME undefined"
        return;
    fi

    rm -rf ${VENV_HOME}/${1}
}

function workon() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: ${FUNCNAME[0]} <venv name>"
        return;
    fi

    if [[ -z "${VENV_HOME}" ]]; then
        echo "VENV_HOME undefined"
        return;
    fi

    source ${VENV_HOME}/${1}/bin/activate
}
