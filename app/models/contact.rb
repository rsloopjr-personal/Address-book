class Contact < ApplicationRecord
    belongs_to :user
    belongs_to :contact_group
     validate :has_name
     validate :has_contact_information

     scope :order_by_name, -> { order("CASE WHEN contacts.first_name IS NOT NULL AND contacts.first_name != '' THEN LOWER(first_name)  ELSE LOWER(last_name) END") }

    def has_name
        if self.first_name.blank? && self.last_name.blank?
            errors.add(:first_name, "Please enter a First or Last Name")
            errors.add(:last_name, "Please enter a First or Last Name")
        end
    end
    def has_contact_information
        if self.phone_number.blank? && self.contact_email.blank?
            errors.add(:phone_number, "Please enter a Phone Number or Email")
            errors.add(:contact_email, "Please enter a Phone Number or Email")
        end
    end
end
