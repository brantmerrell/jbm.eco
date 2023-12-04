cd html/

pandoc -s ../home.md --css=styles.css -o index.nginx-debian.html

sudo cp . /var/www/html -r
