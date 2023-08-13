require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe "Login" do
    context "with valid login credentials" do
      before do
        @user = User.create(:username => 'test_login', :password => 'password')
        post sessions_path, params: { username: 'test_login', password: 'password' }
      end

      after do
        User.destroy_all
      end


      it "sets the user's ID in the session" do
        expect(session[:current_user_id]).to eq(@user.id)
      end
    end

    context "with invalid login credentials" do
      before do
        post sessions_path, params: { username: 'nonexistentuser', password: 'incorrectpassword' }
      end

      it "does not set the user ID in the session" do
        expect(session[:current_user_id]).to be_nil
      end

      it "sets an error message" do
        expect(flash.now[:alert]).to eq("Wrong password or username. Try again")
      end
    end
  end

  describe "Log out" do
    before do
      @user = User.create(:username => 'test_login', :password => 'password')
      post sessions_path, params: { username: 'test_login', password: 'password' }
    end

    after do
      User.destroy_all
    end

    it "clears the user ID from the session" do
      delete logout_path
      expect(session[:current_user_id]).to be_nil
    end
  end
end
