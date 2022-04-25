# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  album_id   :integer          not null
#  title      :string           not null
#  ord        :integer          not null
#  lyrics     :text
#  bonus      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Track < ApplicationRecord
  validates :title, :ord, presence: true
  validates :bonus, inclusion: { in: [true, false] }
  
  belongs_to :album

  has_one :band,
  through: :album,
  source: :band

  has_many :notes,
  dependent: :destroy
end
