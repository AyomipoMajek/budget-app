class Group < ApplicationRecord
  has_many :group_entities, class_name: 'GroupEntity', foreign_key: 'group_id'
  has_many :entities, through: :group_entities
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true
end