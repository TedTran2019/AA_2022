# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
u1 = User.create!(username: 'ted')
u2 = User.create!(username: 'helen')
u3 = User.create!(username: 'brian')

Artwork.destroy_all
p1 = Artwork.create!(title: 'Sad Cat in a party hat', image_url:'a.com', artist_id: u2.id )
p2 = Artwork.create!(title: 'Monstrous Black Cat attacks city', image_url:'b.com', artist_id: u2.id )
p3 = Artwork.create!(title: "Skald: Helen's DnD character", image_url:'c.com', artist_id: u2.id )
p4 = Artwork.create!(title: 'My hand', image_url:'d.com', artist_id: u1.id )
p5 = Artwork.create!(title: 'Return to Monke, Zeke', image_url:'e.com', artist_id: u3.id )

ArtworkShare.destroy_all
as1 = ArtworkShare.create!(artwork_id: p1.id, viewer_id: u1.id)
as2 = ArtworkShare.create!(artwork_id: p1.id, viewer_id: u2.id)
as3 = ArtworkShare.create!(artwork_id: p1.id, viewer_id: u3.id)
as4 = ArtworkShare.create!(artwork_id: p5.id, viewer_id: u1.id)
as5 = ArtworkShare.create!(artwork_id: p2.id, viewer_id: u1.id)
as6 = ArtworkShare.create!(artwork_id: p3.id, viewer_id: u1.id) 

Comment.destroy_all
c1  = Comment.create!(body: 'Beautiful work', author_id: u1.id, artwork_id: p1.id)
c2  = Comment.create!(body: 'Excellent!', author_id: u3.id, artwork_id: p1.id)
c3  = Comment.create!(body: "It's not good", author_id: u2.id, artwork_id: p4.id)
