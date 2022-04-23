# == Schema Information
#
# Table name: notes
#
#  id          :bigint           not null, primary key
#  track_id    :integer          not null
#  user_id     :integer          not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Note < ApplicationRecord
  validates :description, presence: true 

  belongs_to :user

  belongs_to :track
end
