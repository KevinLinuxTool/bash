#!/bin/bash


#修改数据库信息
sed -i "s/Mysql_Host/$Host/g" /data/wwwroot/zfaka/conf/application.ini
sed -i "s/Mysql_Port/$Port/g" /data/wwwroot/zfaka/conf/application.ini
sed -i "s/Mysql_User/$User/g" /data/wwwroot/zfaka/conf/application.ini
sed -i "s/Mysql_Passwd/$PassWD/g" /data/wwwroot/zfaka/conf/application.ini
sed -i "s/Mysql_DataBase/$DataBase/g" /data/wwwroot/zfaka/conf/application.ini

#配置虚拟主机信息
echo "
server {
    listen       80;
    server_name  $DOMAIN; #换成你的域名
    
    location ~ \.php$ {
            fastcgi_pass   unix:/usr/local/php/var/run/www-php-fpm.sock;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
    }
}
" > /etc/nginx/conf.d/zfaka.conf
certbot --nginx --agree-tos --no-eff-email --email example@$DOMAIN