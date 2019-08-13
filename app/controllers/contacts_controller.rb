class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.where(contact_group_id: session[:contact_group_id]).order_by_name

  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
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
   # @contact.user_id = current_user.id
   # logger.debug "#{@contact.first_name}"
   # logger.debug "#{@contact}"

    respond_to do |format|
     # @current_contact_group = ContactGroup.where( user_id: current_user.id, id: session[:contact_group_id]).first!
     @current_contact_group = current_user.contact_groups.where( id: session[:contact_group_id] ).first! 
     @contact.contact_group_id = @current_contact_group.id
      if @contact.save
        #logger.debug('====== Hi1')
        format.html { redirect_to @contact, notice: 'Contact successfully created.' }
        format.js { redirect_to homes_url, notice: 'Contact successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        #logger.debug('====== Hi2')
        logger.debug(@contact.errors.full_messages)
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
        format.js { redirect_to homes_url, notice: 'Contact was successfully updated.' }
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
      format.html { redirect_to homes_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = current_user.contact_group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :phone_number, :contact_picture, :contact_email)
    end
end
