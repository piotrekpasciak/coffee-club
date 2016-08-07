# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

User.create(email: "piotrek.pasciak@gmail.com", password: "admin123", password_confirmation: "admin123", created_at: Time.now, updated_at: Time.now )

Achievement.create(name: "First coffee!", symbol: "first_coffee", text: "You have drank your first coffee!", image: "coffee.png")
Achievement.create(name: "10 coffees!", symbol: "10_coffees", text: "You have drank 10 coffees already!", image: "coffee.png")
Achievement.create(name: "100 coffees!", symbol: "100_coffees", text: "You're real coffee addict!", image: "coffee.png")

Achievement.create(name: "First event!", symbol: "first_event", text: "You have organized your first event!", image: "coffee.png")
Achievement.create(name: "10 events!", symbol: "10_events", text: "You have organized 10 events already!", image: "coffee.png")
Achievement.create(name: "100 events!", symbol: "100_events", text: "You have organized 100 events already!", image: "coffee.png")

Achievement.create(name: "Highscores!", symbol: "highscores", text: "You have entered highscores!", image: "coffee.png")
Achievement.create(name: "Third place!", symbol: "third_place", text: "You are on third place!", image: "coffee.png")
Achievement.create(name: "Second place!", symbol: "second_place", text: "You are on second place!", image: "coffee.png")
Achievement.create(name: "Coffee leader!", symbol: "coffee_leader", text: "You've become a coffee leader!", image: "coffee.png")

Achievement.create(name: "NO for coffee!", symbol: "no_coffee", text: "You've joined application and didn't drink coffee for a week already!", image: "coffee.png")

Achievement.create(name: "Golden vulture!", symbol: "golden_vulture", text: "You have mastered the craft of vulture! You have drunk 10 coffees without creating your own events!", image: "vulture.png")
