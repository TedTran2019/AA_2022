# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Cat.destroy_all
c1 = Cat.create!(color: 'black', sex: 'M', name: 'Kitty', birth_date: '2019/03/29', description: 'Cute n dumb')
c2 = Cat.create!(color: 'black', sex: 'F', name: 'Demon Cat', birth_date: '2015/02/17', description: 'EVIL AND LOUD')
c3 = Cat.create!(color: 'white', sex: 'F', name: 'Bunny', birth_date: '2010/06/01', description: 'Wild smart cat')

CatRentalRequest.destroy_all
cr1 = CatRentalRequest.create!(cat_id: c1.id, start_date: '2019/03/29', end_date: '2050/03/29')
cr2 = CatRentalRequest.create!(cat_id: c2.id, start_date: '2019/03/29', end_date: '2050/03/29')
cr3 = CatRentalRequest.create!(cat_id: c3.id, start_date: '2019/03/29', end_date: '2050/03/29')