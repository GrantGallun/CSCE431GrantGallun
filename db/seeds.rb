# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Book.find_or_create_by!(title: "The Hobbit") do |book|
  book.author = "J.R.R. Tolkien"
  book.price = 14.99
  book.published_date = Date.new(1937, 9, 21)
end

Book.find_or_create_by!(title: "Dune") do |book|
  book.author = "Frank Herbert"
  book.price = 12.50
  book.published_date = Date.new(1965, 8, 1)
end

Book.find_or_create_by!(title: "The Pragmatic Programmer") do |book|
  book.author = "David Thomas"
  book.price = 39.99
  book.published_date = Date.new(1999, 10, 30)
end

Book.find_or_create_by!(title: "Clean Code") do |book|
  book.author = "Robert C. Martin"
  book.price = 34.99
  book.published_date = Date.new(2008, 8, 1)
end

Book.find_or_create_by!(title: "The Name of the Wind") do |book|
  book.author = "Patrick Rothfuss"
  book.price = 17.99
  book.published_date = Date.new(2007, 3, 27)
end

# Sample users and the books in their collections, so the User Books home page has data.
# find_or_create_by! keeps this safe to run on every release: nothing is duplicated and
# records people added through the app are left alone.
{
  "Axolotl" => [ "Dune", "The Hobbit" ],
  "Turtle person" => [ "The Hobbit", "Clean Code" ],
  "Book Worm" => [ "The Pragmatic Programmer", "The Name of the Wind" ]
}.each do |username, titles|
  user = User.find_or_create_by!(username: username)
  titles.each do |title|
    UserBook.find_or_create_by!(user: user, book: Book.find_by!(title: title))
  end
end
