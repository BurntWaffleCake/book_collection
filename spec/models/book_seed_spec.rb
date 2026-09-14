require "rails_helper"

# These specs read data that db/seeds.rb is expected to have already loaded into
# the test database (via `RAILS_ENV=test bin/rails db:seed`), rather than creating
# their own records. They verify the seed file actually populated the test DB.
RSpec.describe "Seeded data", type: :model do
  it "includes a book from the seed file" do
    expect(Book.find_by(title: "The Hobbit")).to be_present
  end

  it "seeded at least 5 books" do
    expect(Book.count).to be >= 5
  end

  it "includes a user from the seed file" do
    expect(User.find_by(username: "Axolotl")).to be_present
  end

  it "associates seeded users with seeded books" do
    user = User.find_by(username: "Axolotl")
    expect(user.books).not_to be_empty
  end
end
