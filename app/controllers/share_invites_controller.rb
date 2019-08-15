class ShareInvitesController < ApplicationController
  before_action :set_share_invite, only: [:show, :edit, :update, :destroy]
  before_action :set_contact_group, only: [:new, :create]

  # GET /share_invites
  # GET /share_invites.json
  def index
    @pending_share_invites = ShareInvite.where({receiver_id: current_user.id, status: "pending"})
    @accepted_share_invites = ShareInvite.where({receiver_id: current_user.id, status: "accepted"})
    logger.debug "pending- #{@pending_share_invites}"
    logger.debug "accepted- #{@accepted_share_invites}"
  end

  # GET share_invites/:id/accept
  def accept
    logger.debug "params id is set to #{params[:id]}"
    invite = ShareInvite.find(params[:id])
    invite.status = "accepted"
    logger.debug "Invite status is #{invite.status}"
    invite.save
    contact_group = ContactGroup.find(invite.contact_group_id)
    logger.debug "contact_group set to #{contact_group}"
    contact_group.users << User.find(invite.receiver_id)
    redirect_to homes_url, notice: 'Invitation Accepted'
   # @invite = 
  end

  # GET /share_invites/:id/decline
  def decline
    invite = ShareInvite.find(params[:id])
    invite.status = "declined"
    invite.save
    redirect_to homes_url, alert: 'Invitation Declined'
    #link_to "Invites", share_invites_path, remote: true
  end

  # GET /share_invites/1
  # GET /share_invites/1.json
 # def show
 # end

  # GET /share_invites/new
  def new
    logger.debug "new hit"
    @contact_group = ContactGroup.find( params[:contact_group_id])
    logger.debug "@contact_group set to #{@contact_group.group_name}, #{@contact_group}"
    respond_to do |format|
      format.html { logger.debug "Hit as HTML" }
      format.js { logger.debug "Hit as JS" }
    end
  end

  # GET /share_invites/1/edit
 # def edit
 # end

  # POST /share_invites
  # POST /share_invites.json
  def create
    logger.debug "print of params test 1: #{params[:contact_group_id]}"
    logger.debug "print of params test 2: #{params[:share_id]}"
    if User.exists?(email: params[:share_id])
      sharee = User.where(email: params[:share_id]).first!
      #Ensure User being shared to does not already have access to the group
      if sharee.contact_groups.where({ id: params[:contact_group_id] }).blank?
        #Check to see if there is already an invite pending in the users invites
        if ShareInvite.where({receiver_id: sharee.id, contact_group_id: params[:contact_group_id], status: "pending"}).exists?
          respond_to do |format|
            format.html { flash[:modal_alert] = "User already has an invite pending for this group" }
            format.js { flash[:modal_alert] = "User already has an invite pending for this group" }
          end
        else
          #create_invite = ShareInvite.create!( sharer_id: current_user.id, receiver_id: User.where( email: params[:contact_groups][:share_id] ).first.id, contact_group_id: @contact_group.id, status: “pending” )
          create_invite = ShareInvite.create!( sharer_id: current_user.id, receiver_id: sharee.id, contact_group_id: params[:contact_group_id], status: "pending" )

          respond_to do |format|
            format.html { redirect_to homes_url, notice: 'Invite Sent' }
            format.js { redirect_to homes_url, notice: 'Invite Sent' }
          end
        end
      else
        respond_to do |format|
          format.html { flash[:modal_alert] = "Group has already been shared with user" }
          format.js { flash[:modal_alert] = "Group has already been shared with user" }
        end
      end
    else
      respond_to do |format|
        format.html { flash[:modal_alert] = "User does not exist" }
        format.js { flash[:modal_alert] = "User does not exist" }
      end
    end
  end

  # PATCH/PUT /share_invites/1
  # PATCH/PUT /share_invites/1.json
  def update
    respond_to do |format|
      if @share_invite.update(share_invite_params)
        format.html { redirect_to @share_invite, notice: 'Share invite was successfully updated.' }
        format.json { render :show, status: :ok, location: @share_invite }
      else
        format.html { render :edit }
        format.json { render json: @share_invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /share_invites/1
  # DELETE /share_invites/1.json
  def destroy
    contact_group = ContactGroup.find(@share_invite.contact_group_id)
    #logger.debug "Grabbed the contact group #{contact_group} with a list of users of #{contact_group.users}"
    contact_group.users.delete(current_user)
    @share_invite.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: "#{contact_group.group_name} has been removed from your Groups list" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_invite
      @share_invite = ShareInvite.find(params[:id])
    end

    def set_contact_group
      @contact_group = ContactGroup.find( params[:contact_group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_invite_params
      params.require(:share_invite).permit(:sharer_id, :receiver_id, :contact_group_id, :status)
    end
end
