# Install Apache, PHP, Python, Git, and dependancies

#sudo yum install -y httpd php php-process python git gcc automake autoconf libtool make curl-devel libgcc.i686 glibc.i686 php-xml php-mbstring;

# Start Apache on boot and turn off firewall

#sudo chkconfig  httpd on;
#sudo chkconfig iptables off;

# Install inotify-tools to make updating speedy

wget --no-check-certificate http://github.com/downloads/rvoicilas/inotify-tools/inotify-tools-3.14.tar.gz; 
tar xvfz inotify-tools-3.14.tar.gz;
cd inotify-tools-3.14;
./configure --prefix=/usr --libdir=/lib64;
sudo make;
sudo make install;
cd ~ ;
#sudo rm inotify-tools-3.14.tar.gz;
clear;

# Install start-stop-daemon for use in /etc/init.d/dropbox

cd ~ ; wget http://developer.axis.com/download/distribution/apps-sys-utils-start-stop-daemon-IR1_9_18-2.tar.gz;
tar zxvf apps-sys-utils-start-stop-daemon-IR1_9_18-2.tar.gz;
cd apps/sys-utils/start-stop-daemon-IR1_9_18-2/;
sudo gcc start-stop-daemon.c -o start-stop-daemon;
cd ~ ;
#sudo rm apps-sys-utils-start-stop-daemon-IR1_9_18-2.tar.gz
clear;

# Install deploysecondcrack

cd ~;
sudo git clone git://github.com/muslax/deploysecondcrack.git;
clear;

# Install Dropbox
    
cd ~ && wget -O - http://www.dropbox.com/download?plat=lnx.x86_64 | tar xzf -
sudo mkdir -p ~/Dropbox;
sudo chown -R $USER:$USER ~/Dropbox;
sudo chmod -R u+rw ~/Dropbox;
sudo mkdir -p ~/.dropbox;
sudo chown -R $USER:$USER ~/.dropbox;
sudo chmod -R u+rw ~/.dropbox;
sudo chmod -R o+x  ~/Dropbox;
clear;

# Install Dropbox service

cd ~; sudo cp ~/deploysecondcrack/config-files/dropbox-service /etc/init.d/dropbox;
sudo cp ~/deploysecondcrack/config-files/sysconfig-dropbox /etc/sysconfig/dropbox;
sudo chmod 755 /etc/init.d/dropbox
sudo chkconfig --add dropbox;
sudo chkconfig dropbox on;
clear;

# Install Dropbox CLI

mkdir -p ~/bin;
sudo wget -O /usr/bin/dropbox "http://www.dropbox.com/download?dl=packages/dropbox.py";
sudo chmod 755 /usr/bin/dropbox;
clear;

# Set up Second Crack `update` cron
  
sudo crontab ~/deploysecondcrack/config-files/crontab.example;

# Config Apache with default settings

#sudo cp ~/deploysecondcrack/config-files/httpd.conf /etc/httpd/conf/httpd.conf;
#sudo service iptables stop;
#sudo rm /etc/httpd/conf.d/welcome.conf;
sudo chmod o+x ~;

# Config PHP settings for short_open_tags

#sudo cp ~/deploysecondcrack/config-files/php.ini /etc/php.ini;

# Install Second Crack

cd ~/ ;
sudo git clone git://github.com/muslax/secondcrack.git;
clear;

# Configure Second Crack

# - Assuming we start with new installation, hence no Blog folder
sudo mkdir -p ~/Dropbox/Blog/templates/;
sudo cp ~/secondcrack/example-templates/main.php ~/Dropbox/Blog/templates/main.php;
sudo cp ~/secondcrack/example-templates/rss.php ~/Dropbox/Blog/templates/rss.php;
sudo mkdir -p ~/Dropbox/Blog/assets/css/;
sudo cp ~/deploysecondcrack/config-files/main.css ~/Dropbox/Blog/assets/css/main.css;
sudo mkdir -p ~/secondcrack/www/;
sudo ln -s ~/Dropbox/Blog/assets ~/secondcrack/www/assets;
sudo mkdir -p ~/Dropbox/Blog/drafts/_previews/;
sudo mkdir -p ~/Dropbox/Blog/drafts/_publish-now/;
sudo mkdir -p ~/Dropbox/Blog/posts/;
sudo chmod -R o+x  ~/Dropbox;
sudo chown -R blog:blog ~/secondcrack/;
sudo chown -R blog:blog ~/Dropbox/;
sudo chown -R blog:blog ~/deploysecondcrack;
sudo cp ~/deploysecondcrack/config-files/config.php.example ~/secondcrack/config.php;
sudo vi ~/secondcrack/config.php;
clear;

echo "1. Make sure Apache DocumentRoot is properly set to /home/blog/secondcrack/www";
echo "2. Edit /etc/php.ini to enable short_open_tags";
echo "3. Edit ~/.dropbox-dist/dropboxd; add \"export LANGUAGE=en\" (whithout quote) after first line.";
echo "4. If directory assets isn't accessible, try \"sudo chmod -R o+x  ~/Dropbox;\"";
echo "5. If yo had such a message: `Can't sync "\"my-new-post.md\" (permission denied)`...";
echo "   try: `sudo chown -R blog:blog \~\/Dropbox\/Blog\/drafts\/`";
echo "6. Restart httpd";

# Manual
# 1. Make sure Apache DocumentRoot is properly set to /home/blog/secondcrack/www
# 2. Edit /etc/php.ini to enable short_open_tags
# 3. Edit ~/.dropbox-dist/dropboxd; add "export LANGUAGE=en" (whithout quote) after first line.
# 4. If directory assets isn't accessible, try "sudo chmod -R o+x  ~/Dropbox;"
# 5. Restart httpd
