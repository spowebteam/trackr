class Contact < ActiveRecord::Base
  attr_accessible :address, :designation, :email, :landline, :mobile, :name
  validates :name, presence: true , length: {minimum:2,maximum:100}
  validates :address, length: {minimum:2,maximum:100}
  VALID_PHONE_REGEX = /\A[[\+?[0-9\-\s\(\)\/\,]*]\,]*\z/
  validates :mobile, format: {with: VALID_PHONE_REGEX}
  validates :landline, format: {with:VALID_PHONE_REGEX}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  before_save {|contact| contact.email = email.downcase}
end
