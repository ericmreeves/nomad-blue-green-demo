#!/bin/sh

echo '--- Starting Simple HTTP Server'
echo '<html><head><style>body {background-color: #FF0000;}</style><title>Web Application 3.0</title></head><body><p style="font-family: Arial;font-size: 24px;font-weight: bold">Web Application 3.0 ('$(hostname)')</p> <div class="youtube-embed"><div> <iframe width="640px" height="395px" src="https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1#x?start=0" ></iframe> </div></div> </body></html>' > /www/index.html

python3 -m http.server 8080
