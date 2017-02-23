class ContactsController < ApplicationController
  before_action :require_user
  before_action :set_user
  before_action :set_contact, only: [:edit, :show, :update, :destroy]

  def index
    @contacts = @user.contacts.sort_by { |c| c.name }
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.creator = current_user

    if @contact.save
      flash[:notice] = "Your contact was created"
      redirect_to contacts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      flash[:notice] = 'Contact updated successfully'
      redirect_to contact_path(@contact)
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :notes)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
end
