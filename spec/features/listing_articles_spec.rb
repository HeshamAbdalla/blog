require "rails_helper"

RSpec.feature "Listing Articles" do

  before do
    @article1 = Article.create(title: "The Test title", body:"I am a test body")
    @article2 = Article.create(title: "The Test title", body:"I am a test body")
  end

  scenario "List all article" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
end
