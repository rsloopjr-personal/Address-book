class Contact < ApplicationRecord
    belongs_to :user
    validate :has_name
    validate :has_contact_information
    

    def has_name
        errors.add(:base, "Please enter a First or Last Name") if 
        self.first_name.blank? && self.last_name.blank?
    end
    def has_contact_information
        errors.add(:base, "Please enter a Phone Number or Email") if 
        self.phone_number.blank? && self.contact_email.blank?
    end
end
