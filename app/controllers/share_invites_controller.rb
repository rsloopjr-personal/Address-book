class ShareInvitesController < ApplicationController
  before_action :set_share_invite, only: [:show, :edit, :update, :destroy]

  # GET /share_invites
  # GET /share_invites.json
  def index
    @share_invites = ShareInvite.all
  end

  # GET /share_invites/1
  # GET /share_invites/1.json
  def show
  end

  # GET /share_invites/new
  def new
    @share_invite = ShareInvite.new
  end

  # GET /share_invites/1/edit
  def edit
  end

  # POST /share_invites
  # POST /share_invites.json
  def create
    @share_invite = ShareInvite.new(share_invite_params)

    respond_to do |format|
      if @share_invite.save
        format.html { redirect_to @share_invite, notice: 'Share invite was successfully created.' }
        format.json { render :show, status: :created, location: @share_invite }
      else
        format.html { render :new }
        format.json { render json: @share_invite.errors, status: :unprocessable_entity }
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
    @share_invite.destroy
    respond_to do |format|
      format.html { redirect_to share_invites_url, notice: 'Share invite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_invite
      @share_invite = ShareInvite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_invite_params
      params.require(:share_invite).permit(:sharer_id, :receiver_id, :contact_group_id, :status)
    end
end
