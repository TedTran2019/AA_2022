# == Schema Information
#
# Table name: taggings
#
#  id               :bigint           not null, primary key
#  shortened_url_id :integer          not null
#  tag_topic_id     :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Tagging < ApplicationRecord
  belongs_to(
    :url,
    class_name: :ShortenedUrl,
    foreign_key: :shortened_url_id
  )
  
  belongs_to(
    :tag_topic
  )
end
