# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

title1 = "Learn Ruby"
body1 = "Ruby is a cool language"
title2 = "Learn Rails"
body2 = "Rails is a cool framework"
title3 = "Learn React"
body3 = "React is a cool library"
title4 = "Learn JavaScript"
body4 = "JavaScript is a cool language"
title5 = "Learn Python"
body5 = "Python is a cool language"

Todo.destroy_all

Todo.create(title: title1, body: body1)
Todo.create(title: title2, body: body2)
Todo.create(title: title3, body: body3)
Todo.create(title: title4, body: body4)
Todo.create(title: title5, body: body5)
