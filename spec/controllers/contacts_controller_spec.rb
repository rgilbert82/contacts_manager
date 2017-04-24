require "spec_helper"

describe ContactsController do
  describe "GET index" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @contacts if the user is logged in" do
      session[:user_id] = alice.id
      Contact.create(name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello", creator: alice)
      get :index
      expect(assigns(:contacts).count).to eq(1)
    end

    it "redirects to the login page for unauthenticated users" do
      get :index
      expect(response).to redirect_to login_path
    end
  end

  describe "GET new" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @contact for logged in users" do
      session[:user_id] = alice.id
      get :new
      expect(assigns(:contact)).to be_instance_of(Contact)
    end

    it "redirects to the login page for unauthenticated users" do
      get :new
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "creates the contact" do
      session[:user_id] = alice.id
      post :create, contact: { name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello" }
      expect(alice.contacts.count).to eq(1)
    end

    it "redirects to the contacts page" do
      session[:user_id] = alice.id
      post :create, contact: { name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello" }
      expect(response).to redirect_to contacts_path
    end

    it "sets a flash message if the contact is created" do
      session[:user_id] = alice.id
      post :create, contact: { name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello" }
      expect(flash[:notice]).to be_present
    end

    it "renders the :new template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      contact = post :create, contact: { name: "", email: "bob@bob.com", phone: "1234567890", notes: "hello" }
      expect(contact).to render_template(:new)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, contact: { name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello" }
      expect(response).to redirect_to login_path
    end
  end

  describe "GET edit" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:bob) { Contact.create(name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello", creator: alice) }

    it "sets the @contact for logged in users" do
      session[:user_id] = alice.id
      get :edit, id: bob.id
      expect(assigns(:contact)).to eq(bob)
    end

    it "redirects to the login page for unauthenticated users" do
      get :edit, id: bob.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST update" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:bob) { Contact.create(name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello", creator: alice) }

    it "updates the contact" do
      session[:user_id] = alice.id
      post :update, id: bob.id, contact: { name: "Steve" }
      expect(bob.reload.name).to eq("Steve")
    end

    it "sets a flash message" do
      session[:user_id] = alice.id
      post :update, id: bob.id, contact: { name: "Steve" }
      expect(flash[:notice]).to be_present
    end

    it "redirects to the contact page" do
      session[:user_id] = alice.id
      post :update, id: bob.id, contact: { name: "Steve" }
      expect(response).to redirect_to contact_path(bob)
    end

    it "renders the :edit template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      contact = post :update, id: bob.id, contact: { name: "" }
      expect(contact).to render_template(:edit)
    end

    it "redirects to the login page for unauthenticated users" do
      post :update, id: bob.id, contact: { name: "Steve" }
      expect(response).to redirect_to login_path
    end
  end

  describe "POST destroy" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:bob) { Contact.create(name: "Bob", email: "bob@bob.com", phone: "1234567890", notes: "hello", creator: alice) }

    it "deletes the contact" do
      session[:user_id] = alice.id
      post :destroy, id: bob.id
      expect(alice.contacts.count).to eq(0)
    end

    it "redirects to the login page for unauthenticated users" do
      post :destroy, id: bob.id
      expect(response).to redirect_to login_path
    end
  end
end
