class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable, authentication_keys: [:name]

  # def self.find_for_database_authentication(warden_conditions)
  #   name = warden_conditions[:name].to_s.downcase.strip
  #   find_by(name: name, organization_id: warden_conditions[:name])
  # end

  validates :name, uniqueness: true

  # No use email
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
