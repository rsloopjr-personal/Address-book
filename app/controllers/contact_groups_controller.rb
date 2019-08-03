class ContactGroupsController < ApplicationController
  before_action :set_contact_groups, only: [:index]
  before_action :set_contact_group, only: [:show, :edit, :update, :destroy]

  # GET /contact_groups
  # GET /contact_groups.json
  def index
    @contact_groups = ContactGroup.where(user_id: current_user.id)
  end

  # GET /contact_groups/1
  # GET /contact_groups/1.json
  def show
    if @contact_group.user_id != current_user.id
      redirect_to homes_url, alert: "Group does not exist"
    else
      respond_to do |format|
        format.html { session[:contact_group_id] = @contact_group.id; redirect_to homes_url; }
        format.js 
      end
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
    if @contact_group.user_id != current_user.id
      redirect_to homes_url, alert: "Group does not exist"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /contact_groups
  # POST /contact_groups.json
  def create
    @contact_group = ContactGroup.new(contact_group_params)
    @contact_group.user_id = current_user.id

    respond_to do |format|
      if @contact_group.save
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
    @contact_group.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Contact group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_group
      @contact_group = ContactGroup.find(params[:id])
    rescue Exception => error
      redirect_to homes_url, alert: "Group does not exist"
    end

    def set_contact_groups
      @contact_groups = ContactGroup.where(user_id: current_user.id)
    end

    def create_group_if_none
      if @contact_groups.present?
        logger.debug "contact_group exists"
      else
        ContactGroup.create(group_name: "Default", user_id: current_user.id, default: "true" )
        logger.debug "Default contact_group created"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_group_params
      params.require(:contact_group).permit(:group_name)
    end
end
