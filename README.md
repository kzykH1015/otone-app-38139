# アプリケーション名
OTONE

## アプリケーション概要
ユーザーが作品を投稿し、作品をユーザー同士がオススメすることができるアプリ。
ネタバレ防止のために、ユーザー自身が見たい情報を制限することができる。

## URL
https://otone-app-38139.herokuapp.com/

## 接続情報
Basic認証 ID/Pass
  ID: kzyk
  Pass: 1234

テスト用アカウント等
  ネタバレ制限なしアカウント
  メールアドレス: user@one
  パスワード: userone
  ネタバレ制限ありアカウント
  メールアドレス名: user@two
  パスワード: usertwo

## 利用方法
### ネタバレ防止機能
1.ユーザー新規登録時にネタバレを防ぎたい項目を選択することで情報を制限できます。
 (ジャンル、 制作者・会社名、 あらすじ、 発売日・放送日、 コメント の５項目)
2.後から変更する際は、ユーザー情報編集時に再度選択する仕様になっています。
### 作品を投稿
1.ユーザーの新規登録またはログインをした後に、トップページ(作品一覧ページ)の「作品投稿」ボタンから遷移します。
2.必要項目(タイトル、カテゴリー、ジャンル、制作者・会社名、あらすじ、発売日・放送日の6項目)を入力して「投稿する」ボタンを押すと新規投稿ができます。
  ※ジャンルと制作者・会社名の2項目は半角スペースで区切ることで、複数の登録が可能です。
### 作品の情報を編集
1.トップページから作品名をクリックし、作品の詳細ページに移動します。
2.作品詳細ページの「作品の情報を編集する」ボタンをクリックすることで、編集ページに遷移し、情報を編集することができます。
### 作品の検索
1.トップページの「作品検索」ボタンをクリックすることで、検索ページに遷移します。
2.「タイトル」「カテゴリー」「発売日・放送日」の項目を入力またはチェックすることで、該当する作品を検索して結果を表示します。
### 作品のオススメ
1.他のユーザー名をクリックすることで、そのユーザーの詳細画面に遷移します。
2.他ユーザーの詳細画面には「Recommendする」ボタンが表示されているので、そのボタンをクリックすると、オススメ画面に遷移します。
3.「作品リスト」をクリックすると、現在投稿されている作品の一覧が表示されます。その中から作品を選び、IDを「作品ID」の入力欄に入力することで、作品を確定します。
4.その後に、「Recommend]ボタンをクリックするとオススメが完了し、オススメをされたユーザーの詳細画面に、情報が表示されます。
### 作品のお気に入り
1.作品の詳細画面に黒いハートがあり、それをクリックすることでお気に入りに登録され、自身のユーザー詳細ページに情報が表示されます。
### ユーザーのフォロー
1.他ユーザーの詳細画面に星マークがあり、それをクリックすることでそのユーザーをフォローし、自身のユーザー詳細ページに情報が表示されます。
### 作品へのコメント
1.作品の詳細ページにコメントの入力欄にコメントを書き込み、「コメントする」ボタンを押すことで、非同期通信によるコメント投稿ができます。

## アプリケーションを作成した背景

## 洗い出した要件
https://docs.google.com/spreadsheets/d/11gDWPHXDg8K7Iik-7YiJtIFDTYuQJSID20Gp8x-SALU/edit?usp=sharing

## 実装した機能についての画像やGIFおよび、その説明

## 実装予定の機能

## データベース設計

## 画面遷移図

## 開発環境

## ローカルでの動作方法

## 実装において工夫したポイント



## Users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| self_introduction  | text   |                           |
### Association

- has_many :contents
- has_many :comments
- has_many :recommendations
- has_many :favorites


## Contents テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| title         | string     | null: false, unique: true      |
| category_id   | integer    | null: false                    |
| genre         | string     | null: false                    |
| release_date  | date       |                                |
| creator       | string     | null: false                    |
| story_line    | text       |                                |
| user          | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_many :comments
- has_many :recommendations
- has_many :favorites

## Comments テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| comment_text | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| content      | references | null: false, foreign_key: true |
### Association

- has_one :user
- has_one :content

## Recommendations テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| recommend_user | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |
| content        | references | null: false, foreign_key: true |
### Association

- has_one :user
- has_one :content

## Favorites テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| content | references | null: false, foreign_key: true |
### Association

- has_one :user
- has_one :content
