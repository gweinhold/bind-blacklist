#!/bin/bash
./build_blackhole_conf.pl > blackhole.conf
sudo cp /etc/bind/blackhole.conf /etc/bind/blackhole.conf.backup
sudo cp blackhole.conf /etc/bind
sudo service bind9 restart
