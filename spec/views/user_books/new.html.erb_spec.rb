require 'rails_helper'

RSpec.describe "user_books/new", type: :view do
  let(:user) { User.create!(username: "MyString") }
  let(:book) { Book.create!(title: "MyString", author: "MyString", price: 9.99, published_date: Date.today) }

  before(:each) do
    assign(:user_book, UserBook.new(
      user: user,
      book: book
    ))
  end

  it "renders new user_book form" do
    render

    assert_select "form[action=?][method=?]", user_books_path, "post" do
      assert_select "select[name=?]", "user_book[user_id]"

      assert_select "select[name=?]", "user_book[book_id]"
    end
  end
end
