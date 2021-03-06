require 'rails_helper'

RSpec.feature "Creating Articles" do

  before do
    @joy = User.create!(email:"joy@example.com", password:"password")
    login_as(@joy)
  end

  scenario "A user creates a new article" do
    visit "/"
    click_link "New Article"

    fill_in "Title", with: "Creating first article"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Article"

    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by:#{@joy.email}")
  end
  scenario "A user fails to create a new article" do
  visit "/"
  click_link "New Article"

  fill_in "Title", with: ""
  fill_in "Body", with: ""
  click_button "Create Article"

  expect(page).to have_content("Article has not been created")
  expect(page).to have_content("Title can't be blank")
  expect(page).to have_content("Body can't be blank")
  end

end
