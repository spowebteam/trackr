class Company < ActiveRecord::Base
  attr_accessible :address, :identifier, :location, :name, :phone, :url, 
                  :poc_id,:manager_id
  
  has_many :contacts

  belongs_to :pointofcontact, 
  :class_name => 'User', 
  :foreign_key => 'poc_id'

  belongs_to :manager,
  :class_name => 'User',
  :foreign_key => 'manager_id'
  
  has_many :contacts

  has_and_belongs_to_many :teams
  
  validates :name, presence: true , length: {minimum:2,maximum:100}
  validates :identifier,uniqueness:true
  validates :address, presence: true , length: {minimum:2,maximum:100}
  validates :location, presence: true , length: {minimum:2,maximum:100}
  VALID_PHONE_REGEX = /\A\+?[0-9\-\s\(\)]*\z/
  validates :phone, format: {with: VALID_PHONE_REGEX},presence: true 
  VALID_URL_REGEX = /[a-z\d\-.]+\.[a-z]+\z/i
  validates :url, presence: true , format: {with: VALID_URL_REGEX}
end
