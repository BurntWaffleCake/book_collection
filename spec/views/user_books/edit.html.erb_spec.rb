require 'rails_helper'

RSpec.describe "user_books/edit", type: :view do
  let(:user) { User.create!(username: "MyString") }
  let(:book) { Book.create!(title: "MyString", author: "MyString", price: 9.99, published_date: Date.today) }
  let(:user_book) {
    UserBook.create!(
      user: user,
      book: book
    )
  }

  before(:each) do
    assign(:user_book, user_book)
  end

  it "renders the edit user_book form" do
    render

    assert_select "form[action=?][method=?]", user_book_path(user_book), "post" do

      assert_select "select[name=?]", "user_book[user_id]"

      assert_select "select[name=?]", "user_book[book_id]"
    end
  end
end
