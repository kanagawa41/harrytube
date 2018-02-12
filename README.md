Takuya Kishira
(正しい表示をみたいらな　http://marxi.co/　にコピペ)
====

Overview
ハリネズミの動画のみを投稿するサイト

## Description
ハリネズミを飼育していない人は、Youtubeより該当の動画を貼り付ける。
ハリネズミを飼育している人は、自分が投稿した動画を見てもらうために貼り付ける。

## Demo
NONE

## VS.

* ドローンチューブ
https://dronetube.jp

## Requirement
Ruby on Rails
Mariadb
Nginx
Puma

## Usage
writting later

## Install
writting later

## Contribution
1. Fork it ( http://github.com/lens-manage/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## Licence

[MIT]

## Author

[kanagawa41](https://github.com/kanagawa41)

---

## 作成メモ

* レイアウトテンプレート
https://startbootstrap.com/template-overviews/modern-business/

* devise使用例
https://qiita.com/cigalecigales/items/73d7bd7ec59a001ccd74

* bootstrap の修正
https://b.0218.jp/20150207190150.html

* bootstrap の配色テンプレート
https://bootswatch.com/
Flatly
タイトル色 #004065
ヘッダー色 #18BC9C
アンカー色 #18BC9C

* fontawesome
http://fontawesome.io/icons/

* 利用規約テンプレート
http://kiyaku.jp/hinagata/sns.html

* bootstrapの画像調整
http://ashleydw.github.io/lightbox/

* impression管理
https://github.com/charlotte-ruby/impressionist

* タグ管理
https://github.com/mbleigh/acts-as-taggable-on

* フォロワー管理
https://qiita.com/kurkuru/items/ad25569f64e74efdac56

* 色使い(Flatlyに寄せた)
http://tsukuruiroiro.hatenablog.com/entry/web-color
5. 温かみのある「橙」
タイトル色 #004065
ヘッダー色 #FFC776
アンカー色 #F99273

* イラスト元
https://namiharinezumi.tumblr.com/

## 画面

* ユーザ情報
http://192.168.33.10:3000/samples/contact
ニックネーム、アイコンの設定、飼っているハリネズミの名前・種類、性別、飼育歴、ユーチューブ(チャンネル)URL、ツイッターURL、ブログURL

* 記事投稿
http://192.168.33.10:3000/samples/contact
ユーチューブの動画URL、記事タイトル、記事内容、タグを設定できる。

* 記事詳細
http://192.168.33.10:3000/samples/blog_post
投稿したポストの詳細の表示、またお気に入り、コメントができる。

### DB構成
#### DB(htubedb)

#### user_infos(ユーザ詳細)
```
rails g scaffold UserInfo user:references nickname:string hash:string sex:integer has_icon:boolean breed_history:integer youtube_channel_id:string twitter_id:string blog_url:string
```

| 論理名 | 変数名 | 型 | NULL | ユニーク | 参照id | 備考 |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| ユーザID | user_id | integer | × | | 〇 | |
| ニックネーム | nickname | string | × | | | |
| ハッシュ | hash | string | | ○ | | ランダムに降られる |
| 性別 | sex | integer | | | | 0…不明, 1…男, 2…女 |
| アイコン保持 | has_icon | boolean | | | | アイコン名はハッシュ値を使用 |
| 飼育歴 | breed_history | integer | | | | 単位：月 |
| 一言 | one_phrase | string | | | | |
| ユーチューブのチャンネルID | youtube_channel_id | string | | | | |
| ツイッターID | twitter_id | string | | | | |
| ブログURL | blog_url | string | | | | |
| 画像 | image | string | | | | |
※ idはusers.idと同じになる。

#### user_pets(ユーザペット)
```
rails g scaffold UserPet user:references has_icon:boolean pet_name:string pet_birthday:date pet_type:string pet_sex:integer one_phrase:string
```

| 論理名 | 変数名 | 型 | NULL | ユニーク | 参照id | 備考 |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| ユーザID | user_id | integer | × | | 〇 | |
| アイコン保持 | has_icon | boolean | | | | user.hash/user_pets.id.jpg |
| 名前 | pet_name | string | | | 〇 | |
| 誕生日 | pet_birthday | date | | | | yyyy/mmのみ使用 |
| 種類 | pet_type | string | | | | |
| 性別 | pet_sex | integer | | | | 0…不明, 1…男, 2…女 |
| 一言 | one_phrase | string | | | | |
| 画像 | image | string | | | | |

#### posts(記事)
```
rails g scaffold post user_id:references title:string description:text youtube_video_id:string tags:string
```

| 論理名 | 変数名 | 型 | NULL | ユニーク | 参照id | 備考 |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| ユーザID | user_id | integer | × | | 〇 | |
| 記事タイトル | title | string | × | | | |
| 記事説明 | description | text | × | | | |
| ユーチューブのビデオID | youtube_video_id | string | × | | | |
| タグ | tags | string | × | | カンマ区切り | |

#### favorites(お気に入り)
```
rails g scaffold favorite user_id:references post:references
```

| 論理名 | 変数名 | 型 | NULL | ユニーク | 参照id | 備考 |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| ユーザID | user_id | integer | × | 〇 | 〇 | |
| ポストID | post_id | integer | × | 〇 | 〇 | |
※created_at, updated_atは不要

#### comments(コメント)
```
rails g scaffold comment user_id:references post:references comment:string
```

| 論理名 | 変数名 | 型 | NULL | ユニーク | 参照id | 備考 |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| ユーザID | user_id | integer | × | | 〇 | |
| ポストID | post_id | integer | × | | 〇 | |
| コメント | comment | string | × | | | |

FIXME: このテーブルは不要になる可能性大
#### images(画像)
```
rails g scaffold image user:references image_type:references file_name:string
```

| 論理名 | 変数名 | 型 | NULL | ユニーク | 参照id | 備考 |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| ユーザID | user_id | integer | × | ○ | ○ | |
| 画像タイプ | image_type | integer | × | ○ | ○ | |
| ファイル名 | file_name | string | × | ○ | | |

#### ng_words(コメント)
```
rails g scaffold ng_word word:string
```

| 論理名 | 変数名 | 型 | NULL | ユニーク | 参照id | 備考 |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| ワード | word | string | × | ○ | | |

## その他

* 日付のフォーマットを修正する。
* 各編集ボタンはhelperを使用するようにする
* youtubeの動画を埋め込む
```
ユーチューブの動画埋め込み
https://dekiru.net/article/15155/

<iframe width="915" height="515" src="https://www.youtube.com/embed/IB0VohcZ3Nk?rel=0&controls=0&fs=0&modestbranding=1" frameborder="0" allowfullscreen></iframe>

<iframe width="915" height="515" src="https://www.youtube.com/embed/IB0VohcZ3Nk?fs=0" frameborder="0" allowfullscreen></iframe>
```
* ファイルのアップロードの処理を実装する

