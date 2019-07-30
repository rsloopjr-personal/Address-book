class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.where(user_id: current_user.id)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    if @contact.user_id != current_user.id
      redirect_to contacts_url, alert: "Contact does not exist"
    end
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /contacts/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
   # logger.debug "#{@contact.first_name}"
   # logger.debug "#{@contact}"

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact successfully created.' }
        format.js { redirect_to contacts_url, notice: 'Contact successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.js
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contacts_url, notice: 'Contact was successfully updated.' }
        format.js { redirect_to contacts_url, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    rescue Exception => error
      redirect_to contacts_url, alert: "Contact does not exist"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :phone_number, :contact_picture, :contact_email)
    end
end
