export PATH=$(brew --prefix openssl)/bin:$PATH
export PKG_CONFIG_PATH=$(brew --prefix openssl)/lib/pkgconfig:$PKG_CONFIG_PATH
gem install webrick
alias ffi='LDFLAGS="-L/usr/local/opt/libffi/lib" PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"'
bundle config build.eventmachine --with-ldflags=-L$(brew --prefix openssl)/lib
bundle config build.ffi --with-cflags="-Wno-error=implicit-function-declaration"
bundle update --bundler
ffi bundle install --path vendor/bundle
yarn install
