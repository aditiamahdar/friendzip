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
  TARGET_OPTIONS = {
    class_name: 'Relation',
    foreign_key: :target_user_id
  }

  RELATION_OPTIONS = { class_name: 'Relation' }

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  with_options TARGET_OPTIONS do
    has_many :target_relations
    has_many :subscribes_target_relations, -> { is_subscribe }
  end

  with_options RELATION_OPTIONS do
    has_many :friends_relations, -> { is_friend }
    has_many :subscribes_relations, -> { is_subscribe }
    has_many :blocks_relations, -> { is_block }
  end

  has_many :relations
  has_many :friends, through: :friends_relations, source: :target_user
  has_many :subscribers, through: :subscribes_target_relations, source: :user

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

  def subscribers_ids
    subscribes_target_relations.pluck(:user_id)
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

  def mention_emails(text)
    text.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)
  end

  def mention_condition(text)
    User.where(email: mention_emails(text))
  end

  def recipient_ids
    friends_ids | subscribers_ids
  end

  def recipients_of(text)
    User.where(id: recipient_ids).or(mention_condition(text)).pluck(:email)
  end
end
