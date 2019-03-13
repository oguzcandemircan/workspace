#!/bin/bash

# get project name
# echo "your project name ?"
# read project_name

cd `/bin/pwd`


# set project name
project_name=$1

# get config
source ../config/config.sh

# set project folder path
project_path="$projects_path/$project_name"

#
if [ -z "$project_name" ]
    then
        echo "please set new project name"
    else
        # Create project if not exists
        if [ -d "$project_path" ]; 
        then
            echo "project already exists!"
        else
            echo "creating new project..."
            # set ip 
            ip="127.0.0.1"

            # set project domain
            domain="$project_name.local"

            # go nginx conf examples 
            cd "$nginx_path/sites/examples"

            # set project nginx conf
            cp laravel.conf.example ../$project_name.conf
            sed -i "s/laravel/$project_name/g" ../$project_name.conf
            sed -i "s/.test/.local/g" ../$project_name.conf

            # go workspace_bash path
            cd $workspace_bash_builders_path

            # add domain
            sudo bash ./add_etc_hosts.sh $ip $domain

            # go laradock path
            cd $laradock_path

            # install laravel
            docker-compose exec workspace --user=laradock create-project --prefer-dist laravel/laravel $project_name "5.7.*"

            # set storage folder permissions
            docker-compose exec workspace chmod -R 777 $project_name/storage

            # set boostrap cache folder permissions
            docker-compose exec workspace chmod -R 777 $project_name/bootstrap/cache

            # create if not exists database
            docker-compose exec mysql mysql -u root -proot -h localhost homestead -e "CREATE DATABASE IF NOT EXISTS $project_name"

            # go project path
            cd $project_path

            # set project folder permissions
            sudo chown $USER:$USER -R $project_path

            #set .env
            f='.env'

            sudo sed "s/APP_NAME=Laravel/APP_NAME=$project_name/g" "$f" > "$f.new" && mv "$f.new" "$f"

            sudo sed "s#APP_URL=http://localhost#APP_URL=http://$domain#g" "$f" > "$f.new" && mv "$f.new" "$f"

            sudo sed "s/DB_HOST=127.0.0.1/DB_HOST=mysql/g" "$f" > "$f.new" && mv "$f.new" "$f"

            # rm "$f.new"

            # sudo sed "s/DB_DATABASE=homestead/DB_DATABASE=$project_name/g" "$f" > "$f.new" && mv "$f.new" "$f"

            # sudo sed "s/DB_USERNAME=homestead/DB_USERNAME=default/g" "$f" > "$f.new" && mv "$f.new" "$f"

            # sudo sed "s/DB_PASSWORD=secret/DB_PASSWORD=secret/g" "$f" > "$f.new" && mv "$f.new" "$f"

            # go laradock path
            cd $laradock_path

            # Restart nginx
            docker-compose restart nginx

        fi
fi