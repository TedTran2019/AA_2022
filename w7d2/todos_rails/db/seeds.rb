# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

title1 = "Learn Ruby"
body1 = "Learn Ruby on Rails"
title2 = "Learn Rails"
body2 = "Learn Rails on Rails"
title3 = "Learn React"
body3 = "Learn React on Rails"

Todo.destroy_all
Todo.create({title: title1,  body: body1, done: false})
Todo.create({title: title2,  body: body2, done: false})
Todo.create({title: title3,  body: body3, done: false})

Step.destroy_all
Step.create({title: "Learn ONE", body: "Learn Ruby on Rails", done: false, todo_id: 1})
Step.create({title: "Learn ONE", body: "Learn Rails on Rails", done: false, todo_id: 1})
Step.create({title: "Learn TWO", body: "Learn React on Rails", done: false, todo_id: 2})
