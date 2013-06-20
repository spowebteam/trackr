class Company < ActiveRecord::Base
  attr_accessible :address, :location, :name, :phone, :url, 
                  :poc_name,:manager_name,:team_tokens, :description, :status
  
  attr_reader :team_tokens

  belongs_to :pointofcontact, 
  :class_name => 'User', 
  :foreign_key => 'poc_id'

  belongs_to :manager,
  :class_name => 'User',
  :foreign_key => 'manager_id'
  
  has_many :contacts

  def poc_name
    pointofcontact.try(:name)
  end

  def poc_name=(name)
    self.pointofcontact = User.find_by_name(name) if name.present?
  end

  def manager_name
    manager.try(:name)
  end

  def manager_name=(name)
    self.manager = User.find_by_name(name) if name.present?
  end

  has_and_belongs_to_many :teams
  
  def team_tokens=(ids)
    self.team_ids=ids.split(',')
  end

  validates :name, presence: true , length: {minimum:2,maximum:100}
  validates :address, presence: true , length: {minimum:2,maximum:100}
  validates :location, presence: true , length: {minimum:2,maximum:100}
  VALID_PHONE_REGEX = /\A\+?[0-9\-\s\(\)]*\z/
  validates :phone, format: {with: VALID_PHONE_REGEX},presence: true 
  VALID_URL_REGEX = /[a-z\d\-.]+\.[a-z]+\z/i
  validates :url, presence: true , format: {with: VALID_URL_REGEX}
end
