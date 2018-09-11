# == Schema Information
#
# Table name: relations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  friend         :boolean
#  subscribe      :boolean
#  block          :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_relations_on_block           (block)
#  index_relations_on_friend          (friend)
#  index_relations_on_subscribe       (subscribe)
#  index_relations_on_target_user_id  (target_user_id)
#  index_relations_on_user_id         (user_id)
#

class Relation < ApplicationRecord
  belongs_to :user
  belongs_to :target_user, class_name: 'User'

  validates :user_id, :target_user_id, presence: true
  validates :user_id, uniqueness: {scope: :target_user_id}

  def befriend!
    self.update(friend: true)
  end
end
