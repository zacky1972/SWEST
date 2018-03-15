rsync -auzv -e ssh swest.toppers.jp:/var/www/html/SWEST19/lecture program-data/SWEST19/
rsync -auzv -e ssh swest.toppers.jp:/var/www/html/SWEST19/program/interactive-printable.csv program-data/SWEST19/
yarn gulp pre
