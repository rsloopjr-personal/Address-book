class HomesController < ApplicationController
  before_action :set_contact_groups
  before_action :create_group_if_none
  before_action :set_contact_group_session
  before_action :set_share_invites
  before_action :set_welcome_message_shown

  # GET /homes
  # GET /homes.json
  def index
    
#    if session[:welcome_message_shown].present? && session[:welcome_message_shown] == "false"
#      render :js => 'welcome'
#    end 
    @contacts = @current_contact_group.contacts.order_by_name;
    # @contacts = Contact.where({ user_id: "current_user.id", id: "session[:contact_group_id]" }).order_by_name
    respond_to do |format|
      format.html 
      format.js 
    end
  end

  # GET /homes/search_index
  def search_index
    logger.debug "search term is #{params[:search_term]}"
    search_term_lower = params[:search_term].downcase
    logger.debug "lowercased term is #{search_term_lower}"
    @contacts = current_user.contacts.where('first_name ILIKE ? OR last_name ILIKE ? OR phone_number ILIKE ? OR contact_email ILIKE ?', "%#{search_term_lower}%", "%#{search_term_lower}%", "%#{search_term_lower}%", "%#{search_term_lower}%")
    @search_groups_ids = @contacts.distinct.pluck(:contact_group_id)
    if @search_groups_ids.blank?
    else
      logger.debug "Below is an inspect of the array search contacts"
      logger.debug @search_groups_ids.inspect
    end
    render "index" 
    respond_to do |format|
      format.html 
      format.js 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_share_invites
      @pending_share_invites = ShareInvite.where({receiver_id: current_user.id, status: "pending"})
      @accepted_share_invites = ShareInvite.where({receiver_id: current_user.id, status: "accepted"})
    end

    def set_contact_groups
      @contact_groups = current_user.contact_groups.order(:group_name)
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

    def set_welcome_message_shown
      if session[:welcome_message_shown].nil?
        session[:welcome_message_shown] = false
      else
        session[:welcome_message_shown] = true
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.fetch(:home, {})
    end
end
