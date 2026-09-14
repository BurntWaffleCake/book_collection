require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a username" do
    user = User.new(username: "axolotl")
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(username: nil)
    expect(user).not_to be_valid
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "can have many books through user_books" do
    user = User.create!(username: "axolotl")
    book = Book.create!(title: "The Hobbit", author: "J.R.R. Tolkien", price: 9.99, published_date: Date.new(1937, 9, 21))
    UserBook.create!(user: user, book: book)

    expect(user.books).to include(book)
  end
end
