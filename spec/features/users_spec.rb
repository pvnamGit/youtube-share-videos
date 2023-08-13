require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "Sign up", type: :feature do
  context "render sign up page" do
    it "renders the signup page" do
      visit users_path
      expect(page).to have_selector("h2", text: "Register Account Form")
    end
  end
  context "create an account" do
    after do
      User.destroy_all
    end
    it "allows users to sign up" do
      visit users_path

      fill_in "Username", with: "testuser"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"

      click_button "Register Account"

      expect(page).to have_current_path(root_path)
    end

    it "not allows users to sign up because of wrong confirmation password" do
      visit users_path

      fill_in "Username", with: "testuser"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "testpassword"

      click_button "Register Account"

      expect(page).to have_selector("span", text: "Wrong confirmation password")
    end
  end

  context "already have username" do
    before do
      User.create(username: "testuser", password_digest: "password")
    end

    after do
      User.destroy_all
    end
    it 'should not allow to create' do
      visit users_path

      fill_in "Username", with: "testuser"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "testpassword"

      click_button "Register Account"

      expect(page).to have_selector("span", text: "Username testuser already created")
    end
  end
end
