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

  def add_friend(user)
    add_friend_relation(user)
    user.add_friend_relation(self)
    true
  end

  def get_relation(user_id)
    relations.find_or_create_by(target_user_id: user_id)
  end

  def add_friend_relation(user)
    relation = get_relation(user.id)
    relation.befriend!
  end
end
