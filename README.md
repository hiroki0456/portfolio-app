# 概要
一般ユーザー向けの相談サイト。
人には人生において重大な分岐点がいくつか存在することがあると思います。
その際に、誰に相談するでしょうか？
当ポートフォリオは、そんな人生の悩みを「哲学者に相談する」という発想となっております。

# 解決したい課題
人生の分岐点に関わるような悩みを第3者に相談できるようにすること

# なぜその課題か
このアプリでは、一般ユーザーがサイトへ質問を投稿することを通して「哲学者」への相談を実現します。
家族や友人、親友など悩みを相談する相手は基本的に近しい人だと思います。
しかし、近しいからこそ見えない解決策があるのではないかと思っています。
そのため、「哲学者」と呼ばれる人生について論理的に、そして、客観的に研究している方々に相談することで、
新たな悩みの解決策が見つかるのではないか、と思い、このサイトを作成しました。

# 今後の実装予定
- コードのリファクタリング
- zoomなど動画のAPIを使用した実装
- 哲学者ユーザーの一覧ページ
- AWSでドメイン取得
- AWSでSSL化
- テストの充実
- 購入機能に関わるtransaction処理
- dockerを使用したコンテナ開発

# 機能要件
- ユーザー管理機能(ログイン・ログアウト)
- プロフィール機能(一般ユーザー・哲学者ユーザー)
- 相談投稿機能
- コメント機能
- いいね機能(自由になったボタン)
- サブスクリプション機能(Payjp)
- モデルの単体テスト

# 使用技術
## サーバーサイド
- ruby 2.6.5
- Ruby on Rails 6.1

## フロントエンド
- HTML・CSS
- javascript
- vue.js

## インフラ
- AWS(EC2)

## 使用方法

### 一般ユーザー
#### ログイン情報
メールアドレス: hiroki@example.com
パスワード: hiroki0456

トップページ中央にある「問いを立てる」ボタンより、質問を投稿することができます。

### 哲学者ユーザー
メールアドレス: philo@example.com
パスワード: philo0456

画面右上にある「コメントする」ボタンをクリックすると、投稿一覧が表示されます。
コメントしたい投稿をクリックすると、コメント投稿フォームがあるので、コメントを投稿をしてみてください。

## こだわりポイント


# DB設計
## usersテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|email                  |string    |null: false, unique: true     |
|encrypted_password     |string    |null: false                   |
|nickname               |string    |null: false                   |
|gender                 |integer   |null: false                   |
|premium                |boolean   |                              |
|subscription_id        |string    |                              |
|admin                  |boolean   |null: false, default: false   |
|philosopher            |boolean   |default: false                |

## questionsテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|category_id            |integer   |null: false                   |
|title                  |string    |null: false                   |
|question               |text      |null: false                   |
|user                   |references|null: false, foreign_key: true|

## commentsテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|comment                |text      |null: false                   |
|title                  |string    |null: false                   |
|question               |references|null: false, foreign_key: true|
|user                   |references|null: false, foreign_key: true|

## likesテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|comment                |references|null: false, foreign_key: true|
|user                   |references|null: false, foreign_key: true|


## profilesテーブル(STI)

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|content                |text      |                              |
|profile_type           |string    |                              |
|profile                |bigint    |                              |
|user                   |references|null: false, foreign_key: true|

## philosopher_profilesテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|affiliation            |string    |                              |
|research               |text      |                              |

## general_profilesテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|kleshas                |text      |                              |

## cardsテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|customer_id            |string    |                              |
|card_id                |string    |                              |
|user                   |references|null: false, foreign_key: true|

## plansテーブル

|column                 |type      |options                       |
|-----------------------|----------|------------------------------|
|plan_id                |string    |                              |
