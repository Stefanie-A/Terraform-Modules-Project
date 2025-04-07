#!/bin/bash
sudo apt update -y
sudo apt upgrade -y

# Add Ansible PPA (Personal Package Archive)
sudo apt-add-repository --yes --update ppa:ansible/ansible

sudo apt install -y ansible
ansible --version

echo"Welcome admin!"
