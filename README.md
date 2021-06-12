# MemoryTank

<img width="1670" alt="スクリーンショット 2021-06-12 20 05 36" src="https://user-images.githubusercontent.com/75885767/121773812-765b1100-cbb9-11eb-9e5a-828b8d9b3e01.png">

# アプリケーションの概要
効率的なナレッジ蓄積と知識定着を支援するアプリ。<br>
主要機能は以下2点です。<br>
- ユーザは様々なWord(単語)や自作の四択問題をカテゴリ別に管理した上で蓄積ができる
- 蓄積したWordや四択問題はユーザ自身の定着率/正答率に応じて、習得済と未習得の2つのカテゴリに分割して自動管理される<br>

# App URL
- https://www.memory-tank.ga/

# 使用技術
- フロントエンド<br>
  ○ HTML/CSS
- バックエンド<br>
  ○ ruby 2.6.5<br>
  ○ Ruby on Rails 6.0.3
- インフラ<br>
  ○ nginx 1.12<br>
  ○ unicorn 6.0.0<br>
  ○ mysql 5.7<br>
  ○ AWS(CloudFormation/EC2/VPC/ALB/ACM/Route53/RDS)<br>
- その他使用ツール<br>
  ○ Visual Studio Code<br>
  ○ draw.io

# AWS構成図
以下構成をAWSのCloudFormationでコード化し、構築をしました。
<img width="781" alt="スクリーンショット 2021-06-12 20 27 09" src="https://user-images.githubusercontent.com/75885767/121774441-680ef400-cbbd-11eb-883f-81324a475260.png">

# 機能一覧
| 機能  | 概要   | 
| -------- | ------ | 
| アカウント管理機能     | アカウント登録/編集/削除/ログイン/ログアウトができます | 
| Tank管理機能    | Tankと呼ばれる、Word(単語)や四択問題のカテゴリを作成/参照/編集/削除できます | 
| Word管理機能 | ユーザはWord(単語)を登録/参照/編集/削除できます | 
| Question管理機能 | ユーザは自作の四択問題を登録/参照/編集/削除できます | 
| 習得度判定機能 | ユーザが登録した単語や四択問題は、解くことで、正答率に応じて、未習得Tank(正答率70%未満)と習得済Tank(正答率70%以上)に振り分けされます | 

# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| username     | string | null: false |
| password | string | null: false |

### Association

- has_many :words
- has_many :questions

## tanks テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| word     | string | null: false |
| meaning | string | null: false |
| correct_count | integer | null: false |
| uncorrect_count | integer | null: false |
| user_id | integer | null: false |
| tank_id | integer | null: false |

### Association

- belongs_to :user
- belongs_to :tank


## words テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| word     | string | null: false |
| meaning | string | null: false |
| correct_count | integer | null: false |
| uncorrect_count | integer | null: false |
| user_id | integer | null: false |
| tank_id | integer | null: false |

### Association

- belongs_to :user
- belongs_to :tank
