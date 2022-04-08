#!/bin/sh

echo '--- Starting Simple HTTP Server'
echo '<html><head><style>body {background-color: #90EE90;}</style><title>Web Application 2.0</title></head><body><p style="font-family: Arial;font-size: 24px;font-weight: bold">Web Application 2.0 ('$(hostname)')</p></body></html>' > /www/index.html

python3 -m http.server 8080
