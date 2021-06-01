brew install imagemagick
brew install advancecomp gifsicle jhead jpegoptim jpeg optipng pngcrush pngquant jonof/kenutils/pngout
brew install yarn
yarn global add svgo
yarn global add gulp
export PATH=$(brew --prefix openssl)/bin:$PATH
export CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl)"
export RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl)"
rbenv install 2.6.6
rbenv global 2.6.6
#gem install bundler
