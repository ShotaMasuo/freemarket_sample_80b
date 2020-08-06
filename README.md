# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## userテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

### user's Association
- has_one :profile
- has_one :point
- has_one :credit_card
- has_many :favorites
- has_many :comments
- has_many :items
- has_many :sending_destinations
- has_many :purchases
- has_many :deliverys


## profileテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|birth_day|date|null: false|
|user_id|references|foreign_key: true,null: false|

### profile's Association
- belongs_to :user


## pointテーブル

|Column|Type|Options|
|------|----|-------|
|point|integer|default: 0 |
|user_id|references|foreign_key: true,null: false|

### point's Association
- belongs_to :user


## credit_cardテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false, unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## sending_destinationテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|code|integer|null: false|
|prefecture_code|string|null: false|
|city|string|null: false|
|town|string|null: false|
|building|string|null: true|
|tell|string|null: true|
|user_id|references|null: false, foreign_key: true|

### Associations
- has_many :deliveries
- belongs_to :user


## itemテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index|
|price|integer|null: false|
|size|string|null: true|
|condition|integer|null: false|
|brand|string|null: true|
|stage|integer|null: false|
|detail|text|null: false|
|user_id|references|null: false, foreign_key: true|

### Associations
- has_many :favorites
- has_many :comments
- has_many :images
- has_many :categorys, through: :item_category
- has_one :purchase
- has_one :delivery
- belongs_to :user


## item_categoryテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|references|foreign_key: true, null: false|
|category_id|references|foreign_key: true, null: false|

### Association
- belongs_to :category
- belongs_to :item


## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items, through :item_category


## purchaseテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true, null: false|
|item_id|references|foreign_key: true, null: false|

### Association
- belongs_to :item
- belongs_to :user


## imageテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|foreign_key: true, null: false|

### Association
- belongs_to :item

## delivery テーブル（送付先）
|Column|Type|Options|
|------|----|-------|
|prefecture_code|string|null: false|
|ship_days|int|null: false|
|ship_way|int|null: false|
|fee|int|null: false|
|item_id|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|
|sending_destination_id|references|null: false, foreign_key: true|

### Association
belongs_to :item
belongs_to :user
belongs_to :sending_destination

## favorite テーブル（お気に入り）
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
belongs_to :item
belongs_to :user


## comment テーブル（コメント）
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|string|null: false, foreign_key: true|
|items_id|string|null: false, foreign_key: true|

### Association
belongs_to :item
belongs_to :user

