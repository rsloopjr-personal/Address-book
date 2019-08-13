class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  before_action :set_contact_groups
  before_action :create_group_if_none
  before_action :set_contact_group_session

  # GET /homes
  # GET /homes.json
  def index
    @contacts = @current_contact_group.contacts.order_by_name;
    # @contacts = Contact.where({ user_id: "current_user.id", id: "session[:contact_group_id]" }).order_by_name
    respond_to do |format|
      format.html 
      format.js 
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    def set_contact_groups
      @contact_groups = current_user.contact_groups
    end

    def create_group_if_none
      if @contact_groups.present?
        logger.debug "contact_group exists"
      else
        default_contact_group = ContactGroup.create(group_name: "Default", default: "true", owner_id: current_user.id )
        default_contact_group.users << current_user
        @contact_groups = [default_contact_group]
        logger.debug "contact_groups #{default_contact_group}"
        logger.debug "Default contact_group created"
      end
    end

    def set_contact_group_session
      if session[:contact_group_id].present?
        if @current_contact_group = current_user.contact_groups.where( id: session[:contact_group_id]).first
          logger.debug "contact_group_id is #{session[:contact_group_id]}"
        else
          @current_contact_group = current_user.contact_groups.where( default: true ).first!
          logger.debug "contact_group_id is #{session[:contact_group_id]}"
        end
      else
         @current_contact_group = current_user.contact_groups.where( default: true ).first!
         session[:contact_group_id] = @current_contact_group.id
        logger.debug "Default contact_group session created and set to #{session[:contact_group_id]}"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.fetch(:home, {})
    end
end
