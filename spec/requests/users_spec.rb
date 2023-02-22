require 'rails_helper'

RSpec.describe "Users", type: :request do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
    describe "GET /users (:index)" do
      it "renders the users index" do
        get users_url
        expect(response).to have_http_status(200)
        expect(response.body).to include("Users Index")
      end
    end

    describe "POST /users (:create)" do
      it "fails with invalid params" do
        post users_url, params: { user: { username: "amin"} }
      end
    end

    describe "GET /user(:id) (:show)" do
      it "render that user's page" do
        u = User.create(
          username: 'amin',
          password: 'aminbabar'
        )
        # debugger
        get user_url(u.id), params: {id: u.id}
      end
    end

    describe "GET /users (:new)" do
      it "renders the new form" do
        get new_user_url
        expect(response).to have_http_status(200)
        expect(response.body).to include("Sign Up")
      end
    end
end


