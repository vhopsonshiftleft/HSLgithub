sudo apt-get update
sudo apt-get install -y nginx
sudo apt-get install -y default-jdk
sudo apt-get install -y maven
sudo ufw allow 'Nginx Full'
sudo ufw --force enable
sudo systemctl reload nginx
curl https://www.shiftleft.io/download/sl-latest-linux-x64.tar.gz > /tmp/sl.tar.gz && sudo tar -C /usr/local/bin -xzf /tmp/sl.tar.gz
sl auth --org "0a4c8175-57fa-4b4c-91fb-b79b98d4cd3a" --token "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODU5NDYxODksImlzcyI6IlNoaWZ0TGVmdCIsIm9yZ0lEIjoiMGE0YzgxNzUtNTdmYS00YjRjLTkxZmItYjc5Yjk4ZDRjZDNhIiwic2NvcGVzIjpbImFwaTp2MiIsInVwbG9hZHM6d3JpdGUiLCJsb2c6d3JpdGUiLCJwaXBlbGluZXN0YXR1czpyZWFkIiwibG9nOndyaXRlIiwicG9saWNpZXM6cmVhZCJdfQ.TflrHbl4Ypdkj9fsNdy8YocDdFoGhfyWOSZiflYoSec1d2Rymwnx82fKUpU40UUzNcjxPU9113q3npZIYwZdxTJ3A_UXd136ohHBi8hC-ui9C9cGc5w7Cg-0GrWcjT1ixLRP5G1QL_GzU4ozDbbpiRwKeKhguNqGs24DhcIaWl8m1ZcsvloxCkUqFUYxxkb3YfFn7wpa7paRLOQC3ZV2fLzEVwDuoFCuiKrWNZ7GDBtgsR6vB_uP0KImIxqZJhRlYcvcumYvd5UEoZ4cHfwkQJjy35vIkhzEKMSBDiYaX8MHmt4wjbnhGIN8h94afr4tfAGpk-hDzqechw1f_LBAaQ"
git clone https://github.com/arunmecheri/HelloShiftLeft.git
cd HelloShiftLeft
mvn clean package
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.old
sudo cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://127.0.0.1:8081;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
     }
}
EOF
sudo systemctl reload nginx
java -jar target/hello-shiftleft-0.0.1.jar &
# sl run --analyze target/hello-shiftleft-0.0.1.jar --app hello-shiftleft-CD -- java -jar target/hello-shiftleft-0$
