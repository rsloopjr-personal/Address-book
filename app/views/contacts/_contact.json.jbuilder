json.extract! contact, :id, :first_name, :last_name, :phone_number, :contact_picture, :contact_email, :created_at, :updated_at
json.url contact_url(contact, format: :json)
