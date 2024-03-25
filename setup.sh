sudo apt update && sudo apt upgrade -y

sudo apt-get install nginx -y

sudo systemctl enable nginx

sudo systemctl status nginx

sudo echo "server {
        listen 80;
        listen [::]:80;
        root /home/azureuser/apps/ua2_app_server/frontend/build;
        index index.html index.htm index.nginx-debian.html;
        server_name AZUREIPADDRESS;
        location / {
                    try_files $uri /index.html;
                   }
        location /api {
            proxy_pass http://localhost:3001;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
           }
}" >> /etc/nginx/sites-available/ua2_app_server

sudo ln -s /etc/nginx/sites-available/ua2_app_server /etc/nginx/sites-enabled/

sudo service nginx restart

node --version

wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo systemctl start mongod

sudo systemctl enable mongod.service

sudo chown -R mongodb:mongodb /var/lib/mongodb

sudo chown mongodb:mongodb /tmp/mongodb-27017.sock

sudo service mongod restart

sudo systemctl status mongod

pm2 start app.js -i max