# SWEST

## インストール

```
$ brew install yarn
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
$ middleman serve
```

その後，[http://localhost:4567/](http://localhost:4567/) にアクセス

## GitHub Pages へのデプロイ

```
$ rm -rf build
$ middleman deploy
```

その後，[https://zacky1972.github.io/SWEST/](https://zacky1972.github.io/SWEST/) にアクセス
