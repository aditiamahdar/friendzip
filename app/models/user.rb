# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  has_many :relations
  has_many :friends_relations, -> { where(friend: true) }, class_name: 'Relation'
  has_many :friends, through: :friends_relations, source: :target_user
  has_many :subscribes_relations, -> { where(subscribe: true) }, class_name: 'Relation'
  has_many :blocks_relations, -> { where(block: true) }, class_name: 'Relation'

  def add_friend(user)
    add_friend_relation(user)
    user.add_friend_relation(self)
  end

  def get_relation(user)
    relations.find_or_create_by(target_user_id: user.id)
  end

  def add_friend_relation(user)
    get_relation(user).befriend!
  end

  def friends_ids
    friends_relations.pluck(:target_user_id)
  end

  def common_ids(user)
    self.friends_ids & user.friends_ids
  end

  def common_friends_with(user)
    User.where(id: common_ids(user)).pluck(:email)
  end

  def subscribe(user)
    get_relation(user).subscribe!
  end

  def block(user)
    get_relation(user).block!
  end
end
