class CategoryExchange < ApplicationRecord
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id'
  belongs_to :exchange, class_name: 'Exchange', foreign_key: 'exchange_id'
end
