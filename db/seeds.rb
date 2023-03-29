# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(email: "test@test.com", password: "Password1@", username: "Testname", confirmed_at: DateTime.now)
User.create!(email: "testing@test.com", password: "Password1@", username: "Testingname", confirmed_at: DateTime.now)

Game.create!(name: "Test's game", created_by: User.first)
Game.create!(name: "Testings's game", created_by: User.second)

Die.create!(name: "Test Die", game: Game.first)
Die.create!(name: "Testing Die", game: Game.second)
