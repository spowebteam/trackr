class Contact < ActiveRecord::Base
  attr_accessible :address, :designation, :email, :landline, :mobile, :name, :active
  belongs_to :company
  has_many :logs

  validates :name, presence: true , length: {minimum:2,maximum:100}
  validates :address, length: {minimum:0,maximum:1000}
  VALID_PHONE_REGEX = /\A[[\+?[0-9\-\s\(\)\/\,]*]\,]*\z/
  validates :mobile, format: {with: VALID_PHONE_REGEX}
  validates :landline, format: {with:VALID_PHONE_REGEX}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  before_save {|contact| contact.email = email.downcase}
  before_create {|contact| contact.active = true}

  

  def default?
    self.default
  end

  def deleted?
    !self.active
  end

  def active?
    self.active
  end
end
