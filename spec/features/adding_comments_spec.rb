require "rails_helper"

RSpec.feature "Adding reviews to articles" do

  before do
    @joy = User.create(email: "Joy@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "First article", body: "First article body", user: @joy)
  end

  scenario "permits a signed in user to write a review" do
    login_as(@fred)

    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "Aamazing article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("Aamazing article")
    expect(current_path).to eq(article_path(@article.comments.last.id))
  end
end
