# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create!(email: 'Ted')
  user2 = User.create!(email: 'Helen')
  user3 = User.create!(email: 'Brian')
  user4 = User.create!(email: 'Bill')
  user5 = User.create!(email: 'Karen')

  ShortenedUrl.destroy_all
  url1 = ShortenedUrl.create_from_url(user1, 'Ruby on Rails.com')
  url2 = ShortenedUrl.create_from_url(user2, 'Cats.com')
  url3 = ShortenedUrl.create_from_url(user2, 'Graphic Design.com')
  url4 = ShortenedUrl.create_from_url(user2, 'Nobody visit ;(.com')

  Visit.destroy_all
  visit1 = Visit.record_visit!(user1, url2)
  visit2 = Visit.record_visit!(user1, url3)
  visit3 = Visit.record_visit!(user2, url1)
  visit4 = Visit.record_visit!(user3, url2)
  visit5 = Visit.record_visit!(user4, url2)

  TagTopic.destroy_all
  tt1 = TagTopic.create!(topic: 'Career')
  tt2 = TagTopic.create!(topic: 'Cats')
  tt3 = TagTopic.create!(topic: 'Sadness')

  Tagging.destroy_all
  tagging1 = Tagging.create!(shortened_url_id: url1.id, tag_topic_id: tt1.id)
  tagging2 = Tagging.create!(shortened_url_id: url3.id, tag_topic_id: tt1.id)
  tagging3 = Tagging.create!(shortened_url_id: url2.id, tag_topic_id: tt2.id)
  tagging4 = Tagging.create!(shortened_url_id: url4.id, tag_topic_id: tt3.id)
end