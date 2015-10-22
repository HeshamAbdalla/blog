require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do

  describe "POST #create" do
    before do
      @joy = User.create(email: "joy@example.com", password: "password")
    end

    context "signed in user" do
      it "can create a comment" do
        login_user @joy
        article = Article.create(
        title: "First Article",
         body: "First article Body",
         user: @joy)
         post :create, comment: {body: "Awesome post"},
         article_id: article.id
         expect(flash[:success]).to eq("Comment has been created")
      end
    end

    context "non-signed in user" do
      it "is redirected to the sign in page" do
        login_user nil
        article = Article.create(
        title: "First Article",
         body: "First article Body",
         user: @joy)
         post :create, comment: {body: "Awesome post"},
         article_id: article.id
         expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
