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
# Foreign Keys
#
#  fk_rails_...  (target_user_id => users.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#

require 'test_helper'

class RelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
