require "spec_helper"

describe EventsController do
  describe "GET index" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @events if the user is logged in" do
      session[:user_id] = alice.id
      Event.create(title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000", creator: alice)
      get :index
      expect(assigns(:events).count).to eq(1)
    end

    it "redirects to the login page for unauthenticated users" do
      get :index
      expect(response).to redirect_to login_path
    end
  end

  describe "GET new" do
    let(:alice) { User.create(username: "alice", password: "password") }

    it "sets the @event for logged in users" do
      session[:user_id] = alice.id
      get :new
      expect(assigns(:event)).to be_instance_of(Event)
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
      post :create, event: { title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000" }
      expect(alice.events.count).to eq(1)
    end

    it "redirects to the events page" do
      session[:user_id] = alice.id
      post :create, event: { title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000" }
      expect(response).to redirect_to events_path
    end

    it "sets a flash message if the contact is created" do
      session[:user_id] = alice.id
      post :create, event: { title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000" }
      expect(flash[:notice]).to be_present
    end

    it "renders the :new template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      event = post :create, event: { title: "", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000" }
      expect(event).to render_template(:new)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, event: { title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000" }
      expect(response).to redirect_to login_path
    end
  end

  describe "GET edit" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:conf) { Event.create(title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000", creator: alice) }

    it "sets the @event for logged in users" do
      session[:user_id] = alice.id
      get :edit, id: conf.id
      expect(assigns(:event)).to eq(conf)
    end

    it "redirects to the login page for unauthenticated users" do
      get :edit, id: conf.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST update" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:conf) { Event.create(title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000", creator: alice) }

    it "updates the event" do
      session[:user_id] = alice.id
      post :update, id: conf.id, event: { title: "Ruby Conference" }
      expect(conf.reload.title).to eq("Ruby Conference")
    end

    it "sets a flash message" do
      session[:user_id] = alice.id
      post :update, id: conf.id, event: { title: "Ruby Conference" }
      expect(flash[:notice]).to be_present
    end

    it "redirects to the contact page" do
      session[:user_id] = alice.id
      post :update, id: conf.id, event: { title: "Ruby Conference" }
      expect(response).to redirect_to event_path(conf)
    end

    it "renders the :edit template if there is an error in creating the contact" do
      session[:user_id] = alice.id
      event = post :update, id: conf.id, event: { title: "" }
      expect(event).to render_template(:edit)
    end

    it "redirects to the login page for unauthenticated users" do
      post :update, id: conf.id, event: { title: "Ruby Conference" }
      expect(response).to redirect_to login_path
    end
  end

  describe "POST destroy" do
    let(:alice) { User.create(username: "alice", password: "password") }
    let(:conf) { Event.create(title: "JS Conference", location: "Seattle, WA", description: "Hello World!", start_time: "2017-02-24 21:56:00.000000", creator: alice) }

    it "deletes the event" do
      session[:user_id] = alice.id
      post :destroy, id: conf.id
      expect(alice.events.count).to eq(0)
    end

    it "redirects to the login page for unauthenticated users" do
      post :destroy, id: conf.id
      expect(response).to redirect_to login_path
    end
  end
end
