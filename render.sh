cd html/

#d2 ../foo.d2 foo.png --layout=elk --theme=104

pandoc -s ../home.md --css=styles.css -o index.nginx-debian.html

pandoc -s ../foo.md --css=styles.css -o foo.html

pandoc -s ../phase1.md --css=styles.css -o phase1.html

pandoc -s ../README.md --css=styles.css -o readme.html

sudo chown www-data:www-data \
    /var/www/html/index.nginx-debian.html \
    /var/www/html/foo.html \
    /var/www/html/phase1.html \
    /var/www/html/readme.html \
    /var/www/html/styles.css

sudo cp . /var/www/html -r
