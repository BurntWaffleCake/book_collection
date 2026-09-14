require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "should create book" do
    visit books_url
    click_on "New book"

    fill_in "Title", with: @book.title
    fill_in "Author", with: @book.author
    fill_in "Price", with: @book.price
    select @book.published_date.year, from: "book_published_date_1i"
    select @book.published_date.strftime("%B"), from: "book_published_date_2i"
    select @book.published_date.day, from: "book_published_date_3i"
    click_on "Create Book"

    assert_text "Book was successfully created"
    click_on "Back"
  end

  test "should update Book" do
    visit book_url(@book)
    click_on "Edit this book", match: :first

    fill_in "Title", with: @book.title
    click_on "Update Book"

    assert_text "Book was successfully updated"
    click_on "Back"
  end

  test "should destroy Book" do
    visit book_url(@book)
    click_on "Delete this book", match: :first
    click_on "Confirm"

    assert_text "Book was successfully destroyed"
  end
end
