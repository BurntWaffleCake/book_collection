require "rails_helper"

# Navigation is hub-and-spoke with the root (user_books#index) at the center:
# root links to every resource index, every index links back to root, and every
# other page links back to its resource's index.
RSpec.describe "Navigation", type: :request do
  let(:user) { User.create!(username: "axolotl") }
  let(:book) { Book.create!(title: "The Hobbit", author: "J.R.R. Tolkien", price: 9.99, published_date: Date.new(1937, 9, 21)) }
  let(:user_book) { UserBook.create!(user: user, book: book) }

  def expect_link_to(path)
    expect(response.body).to include(%(href="#{path}"))
  end

  describe "root" do
    it "links to every resource index" do
      get root_path

      expect(response).to be_successful
      expect_link_to(books_path)
      expect_link_to(users_path)
      expect_link_to(new_user_book_path)
    end
  end

  describe "resource indexes" do
    it "link back to root" do
      [ books_path, users_path ].each do |path|
        get path

        expect(response).to be_successful
        expect_link_to(root_path)
      end
    end
  end

  describe "resource pages" do
    it "link back to their index" do
      {
        books_path => [ new_book_path, book_path(book), edit_book_path(book) ],
        users_path => [ new_user_path, user_path(user), edit_user_path(user) ],
        user_books_path => [ new_user_book_path, user_book_path(user_book), edit_user_book_path(user_book) ]
      }.each do |index_path, page_paths|
        page_paths.each do |path|
          get path

          expect(response).to be_successful
          expect_link_to(index_path)
        end
      end
    end

    it "lets the book delete confirmation cancel back to the book" do
      get delete_book_path(book)

      expect(response).to be_successful
      expect_link_to(book_path(book))
    end
  end
end
