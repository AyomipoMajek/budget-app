class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :entities, class_name: 'Entity', foreign_key: 'user_id'
  has_many :groups, class_name: 'Group', foreign_key: 'user_id'

  validates :firstname, presence: true
  validates :lastname, presence: true
end
