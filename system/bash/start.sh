#!/bin/bash

# go workspace bash path
cd "$HOME/workspace/system/bash"

source config/config.sh

cd $workspace_path

if [ ! -d "$laradock_path" ]; then
   
    git clone https://github.com/Laradock/laradock.git

    cd $laradock_path

    cp env-example .env

    f=".env"

    sed "s#APP_CODE_PATH_HOST=../#APP_CODE_PATH_HOST=../projects/#g" "$f" > "$f.new" && mv "$f.new" "$f"

    sed "s#MYSQL_USER=default#MYSQL_USER=homestead#g" "$f" > "$f.new" && mv "$f.new" "$f"

    sed "s#MYSQL_DATABASE=default#MYSQL_DATABASE=homestead#g" "$f" > "$f.new" && mv "$f.new" "$f"

    sed "s#MYSQL_DATABASE=secret#MYSQL_DATABASE=secret#g" "$f" > "$f.new" && mv "$f.new" "$f"

    #rm "$f.new"

    cd "$laradock_path/nginx/sites"
    if [ ! -d "examples" ]; then
        mkdir "examples"
        mv app.conf.example examples/app.conf.example
        mv laravel.conf.example examples/laravel.conf.example
        mv symfony.conf.example examples/symfony.conf.example
    fi

    cd "$laradock_path/mysql"
    
    echo "default_authentication_plugin=mysql_native_password" >> my.cnf
fi

cd $workspace_path

if [ ! -d "$projects_path" ]; then
    mkdir $projects_path
fi

cd $HOME

if [ -f ".bash_aliases" ]; then
    mv ".bash_aliases" ".bash_aliases.old"
fi

cd $workspace_bash_path

cp ".bash_aliases" "$HOME/.bash_aliases"