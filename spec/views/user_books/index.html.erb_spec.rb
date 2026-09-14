require 'rails_helper'

RSpec.describe "user_books/index", type: :view do
  before(:each) do
    user = User.create!(username: "Axolotl")
    book = Book.create!(title: "The secret of life", author: "MyString", price: 9.99, published_date: Date.today)

    assign(:user_books, [
      UserBook.create!(user: user, book: book),
      UserBook.create!(user: user, book: book)
    ])
  end

  it "renders a list of user_books" do
    render
    cell_selector = "td"
    assert_select cell_selector, text: "Axolotl", count: 2
    assert_select cell_selector, text: "The secret of life", count: 2
  end
end
