class GroupEntity < ApplicationRecord
  belongs_to :entity, class_name: 'Entity', foreign_key: 'entity_id'
  belongs_to :group, class_name: 'Group', foreign_key: 'group_id'
end