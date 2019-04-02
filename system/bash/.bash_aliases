alias alias-edit='subl ~/.bash_aliases'
# export GOPATH=$HOME/go
# export PATH=$PATH:$(go env GOPATH)/bin

export workspace_path=$HOME/workspace
export workspace_bash_path="$workspace_path/system/bash"
export projects_path="$workspace_path/projects"
export laradock_path="$workspace_path/laradock"

alias cd-workspace="cd $workspace_path"
alias cd-workspace-bash="cd $workspace_bash_path"
alias cd-workspace-bash-builders="cd $workspace_bash_path/builders"
alias cd-projects="cd $projects_path"
alias cd-laradock="cd $laradock_path"

function laradock() {
    ( cd-laradock && docker-compose $* )
}

function nginx() {
    ( laradock exec nginx $* )
}

function nginx-conn() {
    ( laradock exec nginx bash )
}

function mysql() {
    ( laradock exec mysql $* )
}

function mysql-conn() {
    ( laradock exec mysql bash )
}

function workspace() {
	( laradock exec workspace $* )
}

function workspace-conn() {
	( workspace bash )
}

function workspace-bash() {
    ( cd-workspace-bash && bash $* )
}

function workspace-bash-builders() {
    ( cd-workspace-bash-builders && bash $* )
}

function ls-projects() {
	( ls $projects_path -l | grep "^d" | awk -F" " '{print $9}' )
}

function laravel() {
	( workspace-bash $* )
}

function workspace-ssh() {
    ( laradock exec --user=laradock workspace bash)
}

alias new-project='workspace-bash-builders laravel.sh'
alias remove-project='workspace-bash-builders laravel-remove.sh'

alias new-domain='workspace-bash-builders new_domain.sh'


alias laradock-up='laradock up -d nginx mysql'
alias ld-up='laradock-up'
alias laradock-down='laradock down'
alias ld-down='laradock-down'
alias laradock-ssh='laradock exec workspace bash'
alias ld-ssh='laradock-ssh'

# alias workspace-ssh='laradock-ssh'

# function project() {

# if [ $1 == 'new' ]; then
#     workspace-bash-builders laravel.sh
# elif [ $i == 'ls']; then
#     ls-projects
# else
#     echo "$i - sa"
# fi
    
#     # cd-project && $1
# }