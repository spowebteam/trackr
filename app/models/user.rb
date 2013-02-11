# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  level      :integer
#  phone      :string(255)
#  identifier :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :identifier, :level, :name, :phone, :password, :password_confirmation
  has_secure_password

  before_save {|user| user.email = email.downcase}
  before_save :create_remember_token
  before_save :set_deactivated

  validates :name, presence: true , length: {minimum:2,maximum:100}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: true;
  VALID_PHONE_REGEX = /\A\+?[0-9\-\s\(\)]*\z/
  validates :phone, format: {with: VALID_PHONE_REGEX}
  validates :identifier,uniqueness:true
  validates :password, presence:true , length: {minimum:6 }
  validates :password_confirmation, presence: true

  def role 
    if self.level ==0
      return "superadmin"
    elsif self.level==1
      return "admin"
    elsif self.level<10
      return "poweruser"
    elsif self.level<100
      return "user"
    else
      return "unavailable"
    end
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def set_deactivated
      self.level=127
    end

end
