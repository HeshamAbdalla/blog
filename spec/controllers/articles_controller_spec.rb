require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    before do
      @joy = User.create(email: "joy@example.com", password: "password")
    end

    context "owner is allowed to edit his articles" do
      it "renders the edit template" do
        login_user @joy
        article = Article.create(title: "first article", body: "Body of the article", user: @joy)

        get :edit, id: article
        expect(response).to render_template :edit
      end
    end

    context "non-owner is not allowed to edit other users articles" do
      it "redirects to the root path" do
        fred = User.create(email: "fred@example.com", password: "password")
        login_user fred

        article = Article.create(title: "First article", body: "First article body", user: @joy)

        get :edit, id: article
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own article."
        expect(flash[:danger]).to eq message
      end
    end
  end
end
