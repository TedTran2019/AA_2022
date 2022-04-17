# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord
  validates :topic, presence: true

  def popular_links
    links
    .joins(:visits)
    .group(:short_url, :long_url)
    .order('COUNT(visits.id) DESC')
    .select('long_url, short_url, COUNT(visits.id) AS visits')
    .limit(5)
  end

  has_many (
    :taggings
  )

  has_many :links,
  through: :taggings,
  source: :url
end
