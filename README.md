# MemoryTank
効率的なナレッジ蓄積と知識定着を支援するアプリケーション
<img width="1670" alt="スクリーンショット 2021-06-12 20 05 36" src="https://user-images.githubusercontent.com/75885767/121773812-765b1100-cbb9-11eb-9e5a-828b8d9b3e01.png">

#本アプリ作成への想い

##目的
何かを学ぼうとする方にジャンルを問わず、効率的なナレッジ蓄積と知識定着が可能なサービスを提供する。
例)
・小学生などの子供が興味を持った事柄や学んだ事柄を整理・定着できる
・中学〜大学受験のために学んだ知識を整理・定着できる
・社会人の資格試験に向けた知識を整理・定着できる

##ターゲット
・何かを学ぼうとしている方
・学んだことを効率的に整理・定着したいと考えている方

##ターゲットの抱える課題と解決方法
日々、学ぶことは沢山あるけれど、忘れないようにするために、どのように知識の整理をすれば良いか分からない。
以下のアプリケーションの主要機能により、解決する。

# アプリケーションの機能
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

- has_many :tanks
- has_many :words
- has_many :questions

## tanks テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| tank_name     | string | null: false |
| tank_type     | string | null: false |
| user_id | integer | null: false |

### Association
- has_many :words
- has_many :questions

## words テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| word     | string | null: false |
| meaning | string | null: false |
| correct_count | integer | null: false |
| uncorrect_count | integer | null: false |
| correct_rate | integer | null: false |
| user_id | integer | null: false |
| tank_id | integer | null: false |

### Association

- belongs_to :user
- belongs_to :tank


## questions テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
|   question   | string | null: false |
|   answer_a   | string | null: false |
|   answer_b   | string | null: false |
|   answer_c   | string | null: false |
|   answer_d   | string | null: false |
|   correct_answer   | string | null: false |
|   description   | string | null: false |
| correct_count | integer | null: false |
| uncorrect_count | integer | null: false |
| correct_rate | integer | null: false |
| user_id | integer | null: false |
| tank_id | integer | null: false |


### Association

- belongs_to :user
- belongs_to :tank
