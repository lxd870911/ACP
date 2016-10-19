#!/bin/bash

#================================================================
# Info    : Cloudbang manage node setup websocket service script
# Author  : zhouyq@goodrain.com
# Version : 1.0.0
# Histroy : 
#           2016.10.19 解决sed替换匹配错误的bug
#================================================================

CFG="/etc/goodrain/console.py"

function PrintInfo {
  infotype=$1
  info=$2

  if [ "$infotype" == "info" ];then
    echo -e "\033[32m$infotype:\033[0m: $2"
  else
    echo -e "\033[31m$infotype:\033[0m $2"
  fi

}

clear

eth0=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`

if [ "$eth0" == "" ];then
  PrintInfo "error" "eth0 ip address error,please set it."
  exit 1
else
  PrintInfo "info" "eth0: $eth0,setup websocket service..."
  PrintInfo "info" "backup config file..."
  cp $CFG ${CFG}.bak
  sleep 1
  sed -i -r "s#(ws://).*(:6060/websocket)#\1$eth0\2#" $CFG && \
  sed -i -r "s#(: ').*(:8188)#\1$eth0\2#" $CFG && \
  PrintInfo "info" "Websocket setting is successful." && \
  PrintInfo "info" "Restart console service..." && \
  dc-compose restart console
fi
