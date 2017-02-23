class NotesController < ApplicationController
  before_action :require_user
  before_action :set_user
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = @user.notes.sort_by { |n| n.created_at }
  end

  def show
    @body_with_links = '' + @note.body

    @user.contacts.each do |c|
      @body_with_links.gsub!(/#{c.name}/i, "<a href='/contacts/#{c.id}'>#{c.name}</a>")
    end
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.creator = @user

    if @note.save
      flash[:notice] = 'You created a note'
      redirect_to notes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      flash[:notice] = 'Your note has been updated'
      redirect_to note_path(@note)
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
