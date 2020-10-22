#!/bin/sh

# 优先判断是否是 -v 多用户模式
if [ -e /opt/nginx/conf/htpasswd ]; then exit 0; fi

# 再判断是否是 -e 单用户模式
if [ -n "$USERNAME" ]
then
  htpasswd -bc /opt/nginx/conf/htpasswd $USERNAME $PASSWORD
  echo "generate htpasswd"
  exit 0
fi

# 两种用户模式都没有设置，则报错提示
echo "检查是否设置用户"
exit 1
