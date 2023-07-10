class Entity < ApplicationRecord
  has_many :group_entities, class_name: 'GroupEntity', foreign_key: 'entity_id'
  has_many :groups, through: :group_entities
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true
  validates :amount, numericality: { greater_than: 0 }
end