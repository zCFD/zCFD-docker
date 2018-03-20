# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

source /opt/rh/devtoolset-4/enable
source /opt/rh/rh-git29/enable
source /opt/rh/python27/enable
source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh intel64
export INTEL_LICENSE_FILE=28000@127.0.0.1
export PATH=${PATH}:/usr/lib64/mpich-3.2/bin/:/usr/local/cuda/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib64/mpich-3.2/lib

# Ignore .ssh/config file as it can contain MacOS specific entries
export GIT_SSH_COMMAND="ssh -F /dev/null"

alias starttunnel='ssh -f -N -T -M -F ~/.ssh/docker_config intellic'
alias stoptunnel='ssh -T -O "exit" -F ~/.ssh/docker_config intellic'
