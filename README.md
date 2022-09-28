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
