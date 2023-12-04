cd /home/ubuntu/jbm.eco/

#d2 ../foo.d2 foo.png --layout=elk --theme=104

pandoc -s ./md/home.md --css=/styles.css -o ./html/index.nginx-debian.html

pandoc -s ./md/foo.md --css=/styles.css -o ./html/foo.html

pandoc -s ./md/foo.bar.md --css=/styles.css -o ./html/foo.bar.html

pandoc -s ./md/phase1.md --css=/styles.css -o ./html/phase1.html

pandoc -s ./md/README.md --css=/styles.css -o ./html/readme.html

sudo cp ./html /var/www -r

sudo chown www-data:www-data \
    /var/www/html/index.nginx-debian.html \
    /var/www/html/foo.html \
    /var/www/html/foo.bar.html \
    /var/www/html/phase1.html \
    /var/www/html/readme.html \
    /var/www/html/styles.css

