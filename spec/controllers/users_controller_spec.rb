require "spec_helper"

describe UsersController do
  describe "GET new" do
    it "sets the @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    it "creates the user" do
      post :create, user: { username: "alice", password: "password" }
      expect(User.count).to eq(1)
    end

    it "logs in the user" do
      post :create, user: { username: "alice", password: "password" }
      expect(session[:user_id]).to eq(User.first.id)
    end

    it "sets a flash message" do
      post :create, user: { username: "alice", password: "password" }
      expect(flash[:notice]).to be_present
    end

    it "redirects to the root page" do
      post :create, user: { username: "alice", password: "password" }
      expect(response).to redirect_to root_path
    end

    it "renders the new template if there is an error" do
      alice = post :create, user: { username: "", password: "password" }
      expect(alice).to render_template(:new)
    end
  end

  describe "GET edit" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @user" do
      session[:user_id] = alice.id
      get :edit, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end

    it "redirects to the login page for unauthenticated users" do
      get :edit, id: alice.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST update" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "updates the user" do
      session[:user_id] = alice.id
      post :update, id: alice.id, user: { username: "bob", password: "password" }
      expect(alice.reload.username).to eq("bob")
    end

    it "sets a flash message" do
      session[:user_id] = alice.id
      post :update, id: alice.id, user: { username: "bob", password: "password" }
      expect(flash[:notice]).to be_present
    end

    it "redirects to the root page" do
      session[:user_id] = alice.id
      post :update, id: alice.id, user: { username: "bob", password: "password" }
      expect(response).to redirect_to root_path
    end

    it "renders the edit template if errors are present" do
      session[:user_id] = alice.id
      update = post :update, id: alice.id, user: { username: "", password: "password" }
      expect(update).to render_template(:edit)
    end

    it "redirects to the login page for unauthenticated users" do
      post :update, id: alice.id, user: { username: "bob", password: "password" }
      expect(response).to redirect_to login_path
    end
  end

  describe "POST destroy" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "deletes the user" do
      session[:user_id] = alice.id
      post :destroy, id: alice.id
      expect(User.count).to eq(0)
    end

    it "logs out the user" do
      session[:user_id] = alice.id
      post :destroy, id: alice.id
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects to the root page" do
      session[:user_id] = alice.id
      post :destroy, id: alice.id
      expect(response).to redirect_to root_path
    end

    it "redirects to the login page for unauthenticated users" do
      post :destroy, id: alice.id
      expect(response).to redirect_to login_path
    end
  end
end
