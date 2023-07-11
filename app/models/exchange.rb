class Exchange < ApplicationRecord
  has_many :category_exchanges, class_name: 'CategoryExchange', foreign_key: 'exchange_id', dependent: :destroy
  has_many :categories, through: :category_exchanges
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true, length: { maximum: 50 }
  validates :amount, numericality: { greater_than: 0 }
end
