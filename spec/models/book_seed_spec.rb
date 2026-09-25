require "rails_helper"

# These specs verify that db/seeds.rb populates the database as expected.
# The seed file is idempotent, so loading it here is safe even if the test DB
# was already seeded via `RAILS_ENV=test bin/rails db:seed`.
RSpec.describe "Seeded data", type: :model do
  before { Rails.application.load_seed }

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
