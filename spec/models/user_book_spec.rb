require 'rails_helper'

RSpec.describe UserBook, type: :model do
  let(:user) { User.create!(username: "axolotl") }
  let(:book) { Book.create!(title: "The Hobbit", author: "J.R.R. Tolkien", price: 9.99, published_date: Date.new(1937, 9, 21)) }

  it "is valid with a user and a book" do
    user_book = UserBook.new(user: user, book: book)
    expect(user_book).to be_valid
  end

  it "is invalid without a user" do
    user_book = UserBook.new(user: nil, book: book)
    expect(user_book).not_to be_valid
  end

  it "is invalid without a book" do
    user_book = UserBook.new(user: user, book: nil)
    expect(user_book).not_to be_valid
  end
end
