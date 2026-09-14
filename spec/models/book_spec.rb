require "rails_helper"

RSpec.describe Book, type: :model do
  let(:valid_attributes) do
    { title: "The Hobbit", author: "J.R.R. Tolkien", price: 9.99, published_date: Date.new(1937, 9, 21) }
  end

  it "is valid with a title" do
    book = Book.new(valid_attributes)
    expect(book).to be_valid
  end

  it "is invalid without a title" do
    book = Book.new(valid_attributes.merge(title: nil))
    expect(book).not_to be_valid
    expect(book.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a blank title" do
    book = Book.new(valid_attributes.merge(title: ""))
    expect(book).not_to be_valid
  end

  it "is valid with an author" do
    book = Book.new(valid_attributes)
    expect(book).to be_valid
  end

  it "is invalid without an author" do
    book = Book.new(valid_attributes.merge(author: nil))
    expect(book).not_to be_valid
    expect(book.errors[:author]).to include("can't be blank")
  end

  it "is valid with a numeric price" do
    book = Book.new(valid_attributes)
    expect(book).to be_valid
  end

  it "is invalid with a negative price" do
    book = Book.new(valid_attributes.merge(price: -5))
    expect(book).not_to be_valid
    expect(book.errors[:price]).to include("must be greater than or equal to 0")
  end

  it "is valid with a published date" do
    book = Book.new(valid_attributes)
    expect(book).to be_valid
  end

  it "is invalid without a published date" do
    book = Book.new(valid_attributes.merge(published_date: nil))
    expect(book).not_to be_valid
    expect(book.errors[:published_date]).to include("can't be blank")
  end
end
