class TodosController < ApplicationController
  before_action :require_user
  before_action :set_user
  before_action :set_todo, only: [:show, :edit, :update, :toggle, :destroy]

  def index
    @todos = @user.todos.sort_by { |t| t.start_time }
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.creator = @user

    if @todo.save
      flash[:notice] = 'Your todo was created'
      redirect_to todos_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      flash[:notice] = 'Your todo was updated'
      redirect_to todo_path(@todo)
    else
      render :edit
    end
  end

  def toggle
    @todo.completed = !@todo.completed
    @todo.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :start_time)
  end
end
