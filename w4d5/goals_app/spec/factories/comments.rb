# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  description      :text             not null
#  author_id        :integer          not null
#  commentable_type :string           not null
#  commentable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :comment do
    
  end
end
