# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2000.times do
  Item.create(name: Faker::Food.ingredient, 
              kcal: rand(201), protein: rand(201), fat: rand(201), carb: rand(201), df: rand(201),
              around_qty: Faker::Lorem.sentence(word_count: 10), unit: "g", weight: 1)
end

2000.times do
  cook_at =
    if rand(2) == 0
      "一般料理"
    else
      "外食・市販"
    end
  Recipe.create(name: Faker::Food.dish, cook_at: cook_at)
end

30.times do |num|
  height = rand(160..200)
  weight = rand(40..150)
  gender =
  if rand(2) == 0
    "male"
  else
    "female"
  end
  birthday = Date.new(rand(1940..2010), rand(1..12), rand(1..29))
  nickname = Faker::Name.last_name

  User.create!(email: "sample#{num}@example.com", height: height, weight: weight,gender: gender,
            birthday: birthday, password: "12341234", nickname: nickname)
end
