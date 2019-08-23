class User < ApplicationRecord
  has_and_belongs_to_many :contact_groups, dependent: :destroy
  has_many :contacts, through: :contact_groups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
