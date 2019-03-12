#!/bin/bash


ip_address='127.0.0.1'

echo "Please enter your domain name"
read domain

sudo bash ./add_etc_hosts.sh $ip_address $domain