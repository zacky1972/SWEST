# SWEST

## インストール

```
$ git clone git@github.com:zacky1972/SWEST.git
$ cd SWEST
$ ./install.sh
$ ./setup.sh
$ ./download.sh
```

## アップグレード

```
$ ./upgrade.sh
$ ./download.sh
```


## プレビュー

### ローカルプレビュー

```
$ bundle exec middleman serve
```

その後，[http://localhost:4567/](http://localhost:4567/) にアクセス

### GitHub Pages へのデプロイ＆プレビュー

config.rb 10行目のpreviewをtrueに変更する
```
preview = true
```

以下のコマンドを実行する

```
$ bundle exec middleman deploy
```

その後，[https://zacky1972.github.io/SWEST/](https://zacky1972.github.io/SWEST/) にアクセス

## 本ページへのデプロイ＆公開

branchを切っている場合は，本公開前にmasterにmergeすること．

config.rb 10行目のpreviewをfalseに変更する
```
preview = false
```

```
$ bundle exec middleman deploy
```

その後，[https://swest.toppers.jp](https://swest.toppers.jp)にアクセス

- - -

## ページ表示の遷移

config.rb 10行目のdefaultOptionにて，各ページの表示を変更できる

```
defaultOptions = "p0-s0-i0-r0-R1-S0"
```

- p,s: 未実装
- s: [討議テーマ・セッション募集](https://swest.toppers.jp/proposal)ページの遷移（0:募集前 1:募集中）
- i: [インタラクティブセッション募集](https://swest.toppers.jp/interactive)ページの遷移（0:募集前 1:募集中）
- r: [参加申込み](https://swest.toppers.jp/regist)ページの遷移（0:募集前 1:募集中）
- R: 各募集ページを常時表示するか（常時表示することで決定済み）
- S: サブメニューを有効にするか（無効にすることで決定済み）

config.rb 414行目以降にオプションの対応表がある．
