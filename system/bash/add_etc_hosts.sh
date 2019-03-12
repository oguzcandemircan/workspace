ip=$1
domain=$2
if  grep -q $domain "/etc/hosts"; then
    echo "Domain name already exists !"
else 
    echo "Adding new domain... [$domain]"
    echo -e "$ip $domain" | sudo tee -a /etc/hosts > /dev/null    
    echo "Added new domain [$domain]"
fi