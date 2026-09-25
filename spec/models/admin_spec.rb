require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:google_attrs) do
    {
      email: "admin@tamu.edu",
      full_name: "Reveille",
      uid: "google-uid-123",
      avatar_url: "https://example.com/avatar.png"
    }
  end

  describe ".from_google" do
    context "when no admin exists with the email" do
      it "creates a new admin with the Google profile attributes" do
        expect {
          Admin.from_google(**google_attrs)
        }.to change(Admin, :count).by(1)

        admin = Admin.last
        expect(admin.email).to eq("admin@tamu.edu")
        expect(admin.full_name).to eq("Reveille")
        expect(admin.uid).to eq("google-uid-123")
        expect(admin.avatar_url).to eq("https://example.com/avatar.png")
      end
    end

    context "when an admin already exists with the email" do
      let!(:existing) { Admin.create!(email: "admin@tamu.edu", full_name: "Original Name", uid: "original-uid") }

      it "returns the existing admin without creating a new one" do
        expect {
          expect(Admin.from_google(**google_attrs)).to eq(existing)
        }.not_to change(Admin, :count)
      end

      it "does not overwrite the existing admin's attributes" do
        Admin.from_google(**google_attrs)

        existing.reload
        expect(existing.full_name).to eq("Original Name")
        expect(existing.uid).to eq("original-uid")
      end
    end
  end

  describe "database constraints" do
    it "requires an email" do
      expect {
        Admin.create!(email: nil)
      }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it "does not allow two admins with the same email" do
      Admin.create!(email: "admin@tamu.edu")

      expect {
        Admin.create!(email: "admin@tamu.edu")
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "#destroy" do
    it "deletes the admin" do
      admin = Admin.create!(google_attrs)

      expect {
        admin.destroy
      }.to change(Admin, :count).by(-1)

      expect(Admin.find_by(email: "admin@tamu.edu")).to be_nil
    end

    it "allows the same Google account to be recreated after deletion" do
      Admin.create!(google_attrs).destroy

      expect {
        Admin.from_google(**google_attrs)
      }.to change(Admin, :count).by(1)
    end
  end
end
