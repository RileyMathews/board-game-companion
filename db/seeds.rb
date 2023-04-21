# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(email: "test@test.com", password: "Password1@", username: "Testname", confirmed_at: DateTime.now)
User.create!(email: "testing@test.com", password: "Password1@", username: "Testingname", confirmed_at: DateTime.now)

skyrim = Game.create!(name: "Skyrim", created_by: User.first)
Game.create!(name: "Test's game", created_by: User.first)
Game.create!(name: "Testings's game", created_by: User.second)

skyrim_resources = ResourceGroup.create!(name: "Resources", game: skyrim)
skyrim_armor = ResourceGroup.create!(name: "Armor", game: skyrim)

Die.create!(name: "Player Die", game: skyrim)
Die.create!(name: "Enemy Die", game: skyrim)
Die.create!(name: "Test Die", game: Game.second)
Die.create!(name: "Testing Die", game: Game.third)

Resource.create!(name: "Septims", game: skyrim, resource_group: skyrim_resources)
Resource.create!(name: "Soul Gems", game: skyrim, resource_group: skyrim_resources)
Resource.create!(name: "Ore", game: skyrim, resource_group: skyrim_resources)
Resource.create!(name: "Magic Armor", game: skyrim, resource_group: skyrim_armor)
Resource.create!(name: "Health", game: skyrim, resource_group: nil)
Resource.create!(name: "Test's resource", game: Game.second)
Resource.create!(name: "Testings's resource", game: Game.third)

Face.create!(name: "Circle", count: 3, die: Die.first)
Face.create!(name: "Pyramid", count: 1, die: Die.first)
Face.create!(name: "Triangle", count: 2, die: Die.first)
Face.create!(name: "Miss", count: 1, die: Die.second)
Face.create!(name: "Axe", count: 1, die: Die.second)
Face.create!(name: "Swords", count: 1, die: Die.second)
Face.create!(name: "Fire", count: 1, die: Die.second)
Face.create!(name: "Skull", count: 1, die: Die.second)
Face.create!(name: "Lightning", count: 1, die: Die.second)
Face.create!(name: "test", count: 1, die: Die.fourth)

skyrim_room = Room.create!(name: "Skyrim game night", created_by: User.first, game: skyrim)
Room.create!(name: "Second users room", created_by: User.second, game: skyrim)

skyrim_room.users << User.second
