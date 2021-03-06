class ContactGroupsController < ApplicationController
  before_action :set_contact_groups, only: [:index]
  before_action :set_contact_group, only: [:show, :edit, :update, :destroy, :share_create, :share_new]

  # GET /contact_groups
  # GET /contact_groups.json
  def index
    @contact_groups = ContactGroup.where(user_id: current_user.id)
  end

  # GET /contact_groups/1
  # GET /contact_groups/1.json
  def show
      respond_to do |format|
        format.html { session[:contact_group_id] = @contact_group.id; redirect_to homes_url; }
        format.js 
      end
  end

  # GET /contact_groups/new
  def new
    @contact_group = ContactGroup.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /contact_groups/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /contact_groups
  # POST /contact_groups.json
  def create
    @contact_group = ContactGroup.new(contact_group_params)
    @contact_group.owner_id = current_user.id
    respond_to do |format|
      if @contact_group.save
        @contact_group.users << current_user
        session[:contact_group_id] = @contact_group.id
        format.html { redirect_to @contact_group, notice: 'Contact group was successfully created.' }
        format.js { redirect_to homes_url, notice: 'Group successfully created.' }
        format.json { render :show, status: :created, location: @contact_group }
      else
        format.html { render :new }
        format.js
        format.json { render json: @contact_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_groups/1
  # PATCH/PUT /contact_groups/1.json
  def update
    respond_to do |format|
      if @contact_group.update(contact_group_params)
        format.html { redirect_to @contact_group, notice: 'Contact group was successfully updated.' }
        format.js { redirect_to homes_url, notice: 'Group successfully updated.' }
        format.json { render :show, status: :ok, location: @contact_group }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @contact_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_groups/1
  # DELETE /contact_groups/1.json
  def destroy
    if @contact_group.owner_id == current_user.id
      @contact_group.destroy
      respond_to do |format|
        format.html { redirect_to homes_url, notice: 'Contact group was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to homes_url, alert: "You must be the owner of the group to delete it" }
        format.js { redirect_to homes_url, alert: "You must be the owner of the group to delete it" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_group
      @contact_group = current_user.contact_groups.find(params[:id])
    end

    def set_contact_groups
      @contact_groups = current_user.contact_groups
    end 

    def create_group_if_none
      if @contact_groups.present?
        logger.debug "contact_group exists"
      else
        x = ContactGroup.create(group_name: "Default", default: "true" )
        x.users << current_user
        logger.debug "Default contact_group created"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_group_params
      params.require(:contact_group).permit(:group_name, :share_id, :id)
    end
end
