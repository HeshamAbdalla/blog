require "rails_helper"

RSpec.feature "Signing out signed-in user" do

  before do
    @joy = User.create!(email:"joy@gmail.com", password:"password")
    visit "/"

    click_link "Sign in"
    fill_in "Email", with: @joy.email
    fill_in "Password", with: @joy.password
    click_button "Log in"
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
  end
end
