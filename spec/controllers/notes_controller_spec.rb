require "spec_helper"

describe NotesController do
  describe "GET index" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @notes if the user is logged in" do
      session[:user_id] = alice.id
      Note.create(title: "Hello", body: "World", creator: alice)
      get :index
      expect(assigns(:notes).count).to eq(1)
    end

    it "redirects to the login page for unauthenticated users" do
      get :index
      expect(response).to redirect_to login_path
    end
  end

  describe "GET show" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Note.create(title: "Hello", body: "World", creator: alice) }

    it "sets the @notes if the user is logged in" do
      session[:user_id] = alice.id
      get :show, id: hello.id
      expect(assigns(:note)).to eq(hello)
    end

    it "redirects to the login page for unauthenticated users" do
      get :show, id: hello.id
      expect(response).to redirect_to login_path
    end
  end

  describe "GET new" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @note for logged in users" do
      session[:user_id] = alice.id
      get :new
      expect(assigns(:note)).to be_instance_of(Note)
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
      post :create, note: { title: "Hello", body: "World" }
      expect(alice.notes.count).to eq(1)
    end

    it "redirects to the contacts page" do
      session[:user_id] = alice.id
      post :create, note: { title: "Hello", body: "World" }
      expect(response).to redirect_to notes_path
    end

    it "sets a flash message if the contact is created" do
      session[:user_id] = alice.id
      post :create, note: { title: "Hello", body: "World" }
      expect(flash[:notice]).to be_present
    end

    it "renders the :new template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      contact = post :create, note: { title: "", body: "World" }
      expect(contact).to render_template(:new)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, note: { title: "Hello", body: "World" }
      expect(response).to redirect_to login_path
    end
  end

  describe "GET edit" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Note.create(title: "Hello", body: "World", creator: alice) }

    it "sets the @note for logged in users" do
      session[:user_id] = alice.id
      get :edit, id: hello.id
      expect(assigns(:note)).to eq(hello)
    end

    it "redirects to the login page for unauthenticated users" do
      get :edit, id: hello.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST update" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Note.create(title: "Hello", body: "World", creator: alice) }

    it "updates the note" do
      session[:user_id] = alice.id
      post :update, id: hello.id, note: { title: "Goodbye" }
      expect(hello.reload.title).to eq("Goodbye")
    end

    it "sets a flash message" do
      session[:user_id] = alice.id
      post :update, id: hello.id, note: { title: "Goodbye" }
      expect(flash[:notice]).to be_present
    end

    it "redirects to the contact page" do
      session[:user_id] = alice.id
      post :update, id: hello.id, note: { title: "Goodbye" }
      expect(response).to redirect_to note_path(hello)
    end

    it "renders the :edit template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      note = post :update, id: hello.id, note: { title: "" }
      expect(note).to render_template(:edit)
    end

    it "redirects to the login page for unauthenticated users" do
      post :update, id: hello.id, note: { title: "Goodbye" }
      expect(response).to redirect_to login_path
    end
  end

  describe "POST destroy" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Note.create(title: "Hello", body: "World", creator: alice) }

    it "deletes the note" do
      session[:user_id] = alice.id
      post :destroy, id: hello.id
      expect(alice.notes.count).to eq(0)
    end

    it "redirects to the login page for unauthenticated users" do
      post :destroy, id: hello.id
      expect(response).to redirect_to login_path
    end
  end
end
