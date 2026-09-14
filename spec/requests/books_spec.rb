require "rails_helper"

RSpec.describe "Books", type: :request do
  let(:valid_params) do
    { title: "The Hobbit", author: "J.R.R. Tolkien", price: 9.99, published_date: "1937-09-21" }
  end

  describe "POST /books" do
    context "with a valid title" do
      it "saves the book and shows a success flash notice" do
        expect {
          post books_path, params: { book: valid_params }
        }.to change(Book, :count).by(1)

        expect(response).to redirect_to(Book.last)
        expect(flash[:notice]).to eq("Book was successfully created.")

        follow_redirect!
        expect(response.body).to include("Book was successfully created.")
      end
    end

    context "with a blank title" do
      it "does not save the book and shows an error flash notice" do
        expect {
          post books_path, params: { book: valid_params.merge(title: "") }
        }.not_to change(Book, :count)

        expect(response).to have_http_status(:unprocessable_content)
        expect(flash[:alert]).to include("Title can't be blank")

        expect(response.body).to include("Title can", "blank")
      end
    end

    context "with an author" do
      it "saves the author and displays it on the book's page" do
        post books_path, params: { book: valid_params }

        expect(Book.last.author).to eq("J.R.R. Tolkien")

        follow_redirect!
        expect(response.body).to include("J.R.R. Tolkien")
      end
    end

    context "with a price" do
      it "saves the price and displays it on the book's page" do
        post books_path, params: { book: valid_params }

        expect(Book.last.price).to eq(9.99)

        follow_redirect!
        expect(response.body).to include("9.99")
      end
    end

    context "with a published date" do
      it "saves the published date and displays it on the book's page" do
        post books_path, params: { book: valid_params }

        expect(Book.last.published_date).to eq(Date.new(1937, 9, 21))

        follow_redirect!
        expect(response.body).to include("1937")
      end
    end
  end
end
