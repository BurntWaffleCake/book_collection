# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

books = [
  { title: "The Hobbit", author: "J.R.R. Tolkien", price: 9.99, published_date: Date.new(1937, 9, 21) },
  { title: "Dune", author: "Frank Herbert", price: 12.50, published_date: Date.new(1965, 8, 1) },
  { title: "The Secret of Life", author: "Rudy Rucker", price: 5.99, published_date: Date.new(1985, 3, 15) },
  { title: "Amazing Turtles", author: "Jane Doe", price: 7.25, published_date: Date.new(2010, 6, 1) },
  { title: "Sapiens", author: "Yuval Noah Harari", price: 14.99, published_date: Date.new(2011, 1, 1) },
].map { |attrs| Book.find_or_create_by!(title: attrs[:title]) { |b| b.assign_attributes(attrs) } }

users = [
  { username: "Turtle person" },
  { username: "Axolotl" },
].map { |attrs| User.find_or_create_by!(attrs) }

UserBook.find_or_create_by!(user: users[0], book: books[0])
UserBook.find_or_create_by!(user: users[1], book: books[1])
UserBook.find_or_create_by!(user: users[1], book: books[2])

puts "Seeded #{Book.count} books, #{User.count} users, #{UserBook.count} user_books."
