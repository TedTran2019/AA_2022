# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Bench.destroy_all 
b1 = Bench.create!(description: "Bench 1", lat: 37.789756487244254, lng: -122.40898625390724, seating: 2, rating: 1, comment: "This is a bench")
b2 = Bench.create!(description: "Bench 2", lat: 37.75984, lng: -122.400897, seating: 2, rating: 1, comment: "This is a bench")
b3 = Bench.create!(description: "Bench 3", lat: 37.72984, lng: -122.40897, seating: 2, rating: 1, comment: "This is a bench")
