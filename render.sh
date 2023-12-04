cd html/

d2 ../foo.d2 foo.png --layout=elk --theme=104

pandoc -s ../home.md --css=styles.css -o index.nginx-debian.html

sudo cp . /var/www/html -r
