# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  private    :boolean          default(FALSE), not null
#  user_id    :integer          not null
#  completed  :boolean          default(FALSE), not null
#  title      :string           not null
#  details    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
