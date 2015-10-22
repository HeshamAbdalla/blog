require "rails_helper"

RSpec.feature "Showing an Article" do

  before do
    @joy  = User.create(email: "joy@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Body of the first article", user: @joy)
  end

  scenario "A non-signed in user does not seee Edit or Delete links" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A non-owner signed in cannot see both links" do
    login_as(@fred)
    visit "/"

    click_link @article.title


    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "Owner signed in see both links" do
    login_as(@joy)
    visit "/"

    click_link @article.title

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
