require 'rails_helper'

RSpec.describe "Auths", type: :system do
  before do
    driven_by(:rack_test)
  end

  # pending "add some scenarios (or delete) #{__FILE__}"


  describe "the sign up process" do
    it "has a new user page" do
      visit(new_user_url)
      expect(page).to have_content("Username:")
    end
    it "shows username on the homepage after signup" do
      visit(new_user_url)
      fill_in('Username:', with: "Amin")
      fill_in('Password:', with: "123456")
      click_on("Sign Up")
      save_and_open_page
      expect(page).to have_content("!SHOWPAGE!")
    end
  end

  describe "logging in" do
    it "shows username on the homepage after login" do
      u = User.create(
        username: 'Amin',
        password: '123456'
      )
      visit(new_session_url)
      fill_in('Username:', with: "Amin")
      fill_in('Password:', with: "123456")
      click_on("Log In")
      save_and_open_page
      expect(page).to have_content("Welcome")
    end
  end

  # describe "logging out" do
  #   it "begins with a logged out state" do

  #   end
  #   it "doesn't show username on the homepage after logout" do

  #   end
  # end
end
