#!/usr/bin/env bash 

#Hypervesterv1.0 tool for harvest email address From websites .
#Enabled in two mode 
# NAME : Hypervester
# VERSION : Alpha 1.0
#AUTHOR : Lucifer HR
# 
#In first mode you have to create sitemap manually. You can use (http://www.xml-sitemaps.com/) to create sitemap.
clear
echo "
                                             _                    _   ___  
  /\  /\_   _ _ __   ___ _ ____   _____  ___| |_ ___ _ __  __   _/ | / _ \ 
 / /_/ / | | | '_ \ / _ \ '__\ \ / / _ \/ __| __/ _ \ '__| \ \ / / || | | |
/ __  /| |_| | |_) |  __/ |   \ V /  __/\__ \ ||  __/ |     \ V /| || |_| |
\/ / /  \__, | .__/ \___|_|    \_/ \___||___/\__\___|_|      \_/ |_(_)___/ 
   \/    |___/|_|                                         
			         ~ Hypervester Alpha v1.0  By : Alexcerus HR ~                

"
echo -e "\e[93mVisible options :"

echo -e "\e[97m
1) - Generate sitemap of website than make name urllist.txt & Put in same directory [Fast Fast]
2) - Generate sitemap than harvest email [Slow Automatique Mode]
\e[92m"
read m1
if [ "$m1" = "1" ];then
echo "
[+] The Script start working,be Patient .....
"
cat urllist.txt | while read f1
do

w3m $f1 >> f1
perl -wne'while(/[\w\.]+@[\w\.]+/g){print "$&\n"}' f1 | sort -u >> output.txt
rm f1
done

cat output.txt
echo "
Harvesting is complete.Open output.txt file to view email address.
"
fi

if [ "$m1" = "2" ];then
echo -e "\e[91m
[+] \e[97mEnter Website To Harvest Email Address 
[~] Example : http://test.com \e[92m
"
read choice
echo -e "
\e[91m[+] \e[97mThe script start making urllist of website.So be Patient....
"
wget --spider --recursive --no-verbose --output-file=wgetlog.txt "$choice"
sed -n "s@.\+ URL:\([^ ]\+\) .\+@\1@p" wgetlog.txt | sed "s@&@\&amp;@" > urllist.txt
rm wgetlog.txt
cat urllist.txt | while read f1
do
w3m $f1 >> f1
perl -wne'while(/[\w\.]+@[\w\.]+/g){print "$&\n"}' f1 | sort -u >> output.txt
rm f1
done

cat output.txt
echo "
Harvesting is complete. Open output.txt file to view email address.
"
fi
