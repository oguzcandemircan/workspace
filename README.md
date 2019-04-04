## Setup

```bash
git clone https://github.com/oguzcandemircan/workspace 

cd workspace 

bash system/bash/start.sh
```

## useful commands / available commands / commands

| Command       | Description |
| ------------- |-------------|
| new-laravel | create a new laravel project |
| workspace-ssh | connect workspace container |
| workspace | run command in workspace container |
| cd workspace | go workspace path |
| cd laradock  | go laradock path |
| cd project   | go projects path |
| ls-project   | list projects |
| mysql-conn   | connect mysql container |

| nginx        | docker-compose exec nginx $* |

| ld-up | docker-compose up -d nginx mysql |



```bash
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

alias new-laravel='workspace-bash-builders laravel.sh'
alias new-vue=''
alias remove-project='workspace-bash-builders remove-project.sh'

alias new-domain='workspace-bash-builders new_domain.sh'


alias laradock-up='laradock up -d nginx mysql'
alias ld-up='laradock-up'
alias laradock-down='laradock down'
alias ld-down='laradock-down'
alias laradock-ssh='workspace-ssh'
alias ld-ssh='laradock-ssh'

```
