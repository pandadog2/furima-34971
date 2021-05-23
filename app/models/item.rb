class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :category_id
    validates :status_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :days_to_ship_id
    validates :user, foreign_key: true
  end
end
