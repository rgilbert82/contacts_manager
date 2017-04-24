require "spec_helper"

describe SessionsController do
  describe "GET menu" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the user if logged in" do
      session[:user_id] = alice.id
      get :menu
      expect(assigns(:user)).to eq(alice)
    end

    it "redirects to the login page for unauthenticated users" do
      get :menu
      expect(response).to redirect_to login_path
    end
  end

  describe "GET new" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "redirects to the root page if already logged in" do
      session[:user_id] = alice.id
      get :new
      expect(response).to redirect_to root_path
    end

    it "sets a flash message if already logged in" do
      session[:user_id] = alice.id
      get :new
      expect(flash[:notice]).to be_present
    end
  end

  describe "POST create" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "logs in user" do
      post :create, username: alice.username, password: alice.password
      expect(session[:user_id]).to eq(alice.id)
    end

    it "sets a flash message" do
      post :create, username: alice.username, password: alice.password
      expect(flash[:notice]).to be_present
    end

    it "redirects to the login page for bad username/password" do
      post :create, username: "bob", password: "password"
      expect(response).to redirect_to login_path
    end

    it "sets an error message for bad username/password" do
      post :create, username: "bob", password: "password"
      expect(flash[:error]).to be_present
    end
  end

  describe "POST destroy" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "logs out the user" do
      session[:user_id] = alice.id
      post :destroy
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects to the login page" do
      session[:user_id] = alice.id
      post :destroy
      expect(response).to redirect_to login_path
    end
  end
end
