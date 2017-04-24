require "spec_helper"

describe TodosController do
  describe "GET index" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @todos if the user is logged in" do
      session[:user_id] = alice.id
      Todo.create(title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000", creator: alice)
      get :index
      expect(assigns(:todos).count).to eq(1)
    end

    it "redirects to the login page for unauthenticated users" do
      get :index
      expect(response).to redirect_to login_path
    end
  end

  describe "GET show" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Todo.create(title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000", creator: alice) }

    it "sets the @todo if the user is logged in" do
      session[:user_id] = alice.id
      get :show, id: hello.id
      expect(assigns(:todo)).to eq(hello)
    end

    it "redirects to the login page for unauthenticated users" do
      get :show, id: hello.id
      expect(response).to redirect_to login_path
    end
  end

  describe "GET new" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @todo for logged in users" do
      session[:user_id] = alice.id
      get :new
      expect(assigns(:todo)).to be_instance_of(Todo)
    end

    it "redirects to the login page for unauthenticated users" do
      get :new
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "creates the todo" do
      session[:user_id] = alice.id
      post :create, todo: { title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000" }
      expect(alice.todos.count).to eq(1)
    end

    it "redirects to the contacts page" do
      session[:user_id] = alice.id
      post :create, todo: { title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000" }
      expect(response).to redirect_to todos_path
    end

    it "sets a flash message if the contact is created" do
      session[:user_id] = alice.id
      post :create, todo: { title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000" }
      expect(flash[:notice]).to be_present
    end

    it "renders the :new template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      todo = post :create, todo: { title: "", description: "World", start_time: "2017-03-02 21:54:00.000000" }
      expect(todo).to render_template(:new)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, todo: { title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000" }
      expect(response).to redirect_to login_path
    end
  end

  describe "GET edit" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Todo.create(title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000", creator: alice) }

    it "sets the @todo for logged in users" do
      session[:user_id] = alice.id
      get :edit, id: hello.id
      expect(assigns(:todo)).to eq(hello)
    end

    it "redirects to the login page for unauthenticated users" do
      get :edit, id: hello.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST update" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Todo.create(title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000", creator: alice) }

    it "updates the todo" do
      session[:user_id] = alice.id
      post :update, id: hello.id, todo: { title: "Goodbye" }
      expect(hello.reload.title).to eq("Goodbye")
    end

    it "sets a flash message" do
      session[:user_id] = alice.id
      post :update, id: hello.id, todo: { title: "Goodbye" }
      expect(flash[:notice]).to be_present
    end

    it "redirects to the contact page" do
      session[:user_id] = alice.id
      post :update, id: hello.id, todo: { title: "Goodbye" }
      expect(response).to redirect_to todo_path(hello)
    end

    it "renders the :edit template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      note = post :update, id: hello.id, todo: { title: "" }
      expect(note).to render_template(:edit)
    end

    it "redirects to the login page for unauthenticated users" do
      post :update, id: hello.id, todo: { title: "Goodbye" }
      expect(response).to redirect_to login_path
    end
  end

  describe "POST destroy" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Todo.create(title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000", creator: alice) }

    it "deletes the note" do
      session[:user_id] = alice.id
      post :destroy, id: hello.id
      expect(alice.todos.count).to eq(0)
    end

    it "redirects to the login page for unauthenticated users" do
      post :destroy, id: hello.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST toggle" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:hello) { Todo.create(title: "Hello", description: "World", start_time: "2017-03-02 21:54:00.000000", creator: alice) }

    it "marks the todo as completed" do
      session[:user_id] = alice.id
      post :toggle, id: hello.id
      expect(hello.reload.completed).to be_truthy
    end

    it "marks the todo as incomplete" do
      session[:user_id] = alice.id
      post :toggle, id: hello.id
      post :toggle, id: hello.id
      expect(hello.reload.completed).to be_falsey
    end

    it "redirects to the todos page" do
      session[:user_id] = alice.id
      post :toggle, id: hello.id
      expect(response).to redirect_to todos_path
    end

    it "redirects to the login page for unauthenticated users" do
      post :toggle, id: hello.id
      expect(response).to redirect_to login_path
    end
  end
end
