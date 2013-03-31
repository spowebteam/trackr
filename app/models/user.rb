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
  attr_accessible :email, :identifier, :name, :phone, :password, :password_confirmation
  has_secure_password

  before_save {|user| user.email = email.downcase}
  before_save :create_remember_token
  before_create :set_deactivated
  has_and_belongs_to_many :teams

  validates :name, presence: true , length: {minimum:2,maximum:100}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: true;
  VALID_PHONE_REGEX = /\A\+?[0-9\-\s\(\)]*\z/
  validates :phone, format: {with: VALID_PHONE_REGEX}
  validates :identifier,uniqueness:true
  validates :password, presence:true , length: {minimum:6 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create

   def role 
    if self.level == Global.level[:superadmin]
      return "superadmin"
    elsif self.level==Global.level[:admin]
      return "admin"
    elsif self.level <= Global.level[:poweruser]
      return "poweruser"
    elsif self.level <= Global.level[:user]
      return "user"
    elsif self.level == Global.level[:disabled]
      return "disabled"
    elsif self.level == Global.level[:deleted]
      return "deleted"
    end
  end

  def superadmin?
    if self.level==Global.level[:superadmin]
      true
    end
  end

  def admin?
    if self.level <= Global.level[:admin]
      return true
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
