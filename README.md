# テーブル設計

## users テーブル

| Colum                 | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false, unique: true |
| email                 | string  | null: false, unique: true |
| password              | string  | null: false               |
| password_confirmation | string  | null: false               |
| last_name             | string  | null: false               |
| first_name            | string  | null: false               |
| last_name_kana        | string  | null: false               |
| first_name_kana       | string  | null: false               |
| birthday              | integer | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Colum           | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| category        | string     | null: false                    |
| status          | string     | null: false                    |
| price           | integer    | null: false                    |
| shipping_cost   | string     | null: false                    |
| shipment_source | string     | null: false                    |
| days_to_ship    | string     | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one : oder

## orders テーブル

| Colum            | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| card_information | text       | null: false                    |
| expiration_date  | text       | null: false                    |
| security_code    | text       | null: false                    |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true | 

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Colum        | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| municipality | string     | null: false                    |
| address      | string     | null: false                    |
| phone_number | integer    | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association

- belongs_to :order