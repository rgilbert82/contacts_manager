class EventsController < ApplicationController
  before_action :require_user
  before_action :set_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = @user.events.sort_by { |e| e.start_time }
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = @user

    if @event.save
      flash[:notice] = "Your event has been created"
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Your event was updated"
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :location, :description, :start_time, :end_time)
  end
end
