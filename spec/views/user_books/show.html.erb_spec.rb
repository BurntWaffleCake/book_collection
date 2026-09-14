require 'rails_helper'

RSpec.describe "user_books/show", type: :view do
  before(:each) do
    user = User.create!(username: "Axolotl")
    book = Book.create!(title: "The secret of life", author: "MyString", price: 9.99, published_date: Date.today)

    assign(:user_book, UserBook.create!(user: user, book: book))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Axolotl/)
    expect(rendered).to match(/The secret of life/)
  end
end
