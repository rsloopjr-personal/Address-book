class ContactGroup < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :contacts, dependent: :destroy
    validates :group_name, presence: true
end
