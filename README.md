# MemoryTank

<img width="1670" alt="スクリーンショット 2021-06-12 20 05 36" src="https://user-images.githubusercontent.com/75885767/121773812-765b1100-cbb9-11eb-9e5a-828b8d9b3e01.png">

# アプリケーションの概要
効率的なナレッジ蓄積と知識定着を支援するアプリ。<br>
主要機能は以下2点です。<br>
- ユーザは様々なWord(単語)や自作の四択問題をカテゴリ別に管理した上で蓄積ができる
- 蓄積したWordや四択問題はユーザ自身の定着率/正答率に応じて、習得済と未習得の2つのカテゴリに分割して自動管理される<br>




# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :room_users
- has_many :rooms, through: room_users
- has_many :messages

## rooms テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :room_users
- has_many :users, through: room_users
- has_many :messages

## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user
