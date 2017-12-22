# SWEST

## インストール

```
$ brew install imagemagick
$ brew install advancecomp gifsicle jhead jpegoptim jpeg optipng pngcrush pngquant jonof/kenutils/pngout
$ brew install yarn
$ yarn global add svgo
$ yarn global add parcel-bundler
$ yarn global add gulp
$ rbenv install 2.4.2
$ rbenv global 2.4.2
$ gem install middleman
$ git clone git@github.com:zacky1972/SWEST.git
$ cd SWEST
$ bundle install
$ yarn install
```


## ローカルプレビュー

```
$ bundle exec middleman serve
```

その後，[http://localhost:4567/](http://localhost:4567/) にアクセス

## GitHub Pages へのデプロイ

```
$ rm -rf build
$ bundle exec middleman deploy
```

その後，[https://zacky1972.github.io/SWEST/](https://zacky1972.github.io/SWEST/) にアクセス
(deploy 先を swest.topper.jp にしている場合は，[https://swest.toppers.jp](https://swest.toppers.jp)にアクセス)
