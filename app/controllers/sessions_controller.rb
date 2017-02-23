class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def menu
    if logged_in?
      @user = current_user
      @all_events = []
      @user.notes.each { |n| @all_events << n }
      @user.events.each { |e| @all_events << e }
      @user.todos.each { |t| @all_events << t if !t.completed }
    else
      session[:user_id] = nil if session[:user_id] != nil
      redirect_to login_path
    end
  end

  def new
    if logged_in?
      user_is_logged_in
    end
  end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      login_user!(user)
    else
      flash[:error] = 'Invalid username/password'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    user_is_logged_in
  end
end
