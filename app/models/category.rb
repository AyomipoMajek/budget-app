class Category < ApplicationRecord
  has_one_attached :icon

  has_many :category_exchanges, class_name: 'CategoryExchange', foreign_key: 'category_id', dependent: :destroy
  has_many :exchanges, through: :category_exchanges
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end
