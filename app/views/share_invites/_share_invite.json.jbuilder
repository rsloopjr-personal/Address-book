json.extract! share_invite, :id, :sharer_id, :receiver_id, :contact_group_id, :status, :created_at, :updated_at
json.url share_invite_url(share_invite, format: :json)
