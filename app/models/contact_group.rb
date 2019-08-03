class ContactGroup < ApplicationRecord
  has_many :contacts, dependent: :destroy
    validates :group_name, presence: true
end
