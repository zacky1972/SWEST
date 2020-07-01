#rsync -auzv -e "ssh -p 60022" swest.toppers.jp:/var/www/html/SWEST19/lecture program-data/SWEST19/
#rsync -auzv -e "ssh -p 60022" swest.toppers.jp:/var/www/html/SWEST19/program/interactive-printable.csv program-data/SWEST19/
#rsync -auzv -e "ssh -p 60022" swest.toppers.jp:/var/www/html/SWEST20/lecture program-data/SWEST20/
#rsync -auzv -e "ssh -p 60022" swest.toppers.jp:/var/www/html/SWEST21/lecture program-data/SWEST21/
rsync -auzv -e "ssh -p 60022" swest.toppers.jp:/var/www/html/SWEST22/lecture program-data/SWEST22/
yarn gulp pre
find program-data/*/lecture/data/*.txt | xargs -n 10 nkf -w --overwrite
find program-data/*/lecture/data/*.txt | xargs -n 10 bundle exec ruby text2html.rb
