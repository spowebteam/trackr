class Company < ActiveRecord::Base
  attr_accessible :address, :location, :name, :phone, :url, 
                  :poc_name,:manager_name,:team_tokens, :description, :status,
                  :status_text, :default_contact, :default_contact_id, :poc_id,:manager_id
  
  attr_reader :team_tokens

  belongs_to :pointofcontact, 
  :class_name => 'User', 
  :foreign_key => 'poc_id'

  belongs_to :manager,
  :class_name => 'User',
  :foreign_key => 'manager_id'
  
  has_many :contacts

  has_many :logs
  def poc_name
    pointofcontact.try(:name)
  end

  belongs_to :default_contact,
  :class_name => 'Contact',
  :foreign_key => 'default_contact_id'

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

  before_create :set_status
  before_create :set_active
  
  def status_text
    code=self.status
    keys=Global.status

    if code.nil?
      return "Status undefined"
    elsif code <= keys[:nocontact]
      "No contact exists"
    elsif code <= keys[:uncontacted]
      "Yet to contact"
    elsif code <= keys[:invitesent]
      "Invitation Sent"
    elsif code <= keys[:inviteaccepted]
      "Invitation Accepted"
    elsif code <= keys[:jafsent]
      "JAF Sent"
    elsif code <= keys[:jaffilled]
      "JAF Filled"
    elsif code <= keys[:pptset]
      "PPT Scheduled"
    elsif code <= keys[:pptdone]
      "PPT Done"
    elsif code <= keys[:testset]
      "Test Scheduled"
    elsif code <= keys[:testdone]
      "Test Completed"
    elsif code <= keys[:rejected]
      "Rejected Invitation"
    elsif code <= keys[:novacancy]
      "No Vacancy"
    elsif code <= keys[:contactlater]
      "Contact Later"
    elsif code <= keys[:blacklisted]
      "Blacklisted"
    end
  end

  def set_status
    self.status = Global.level[:nocontact]
  end

  def set_inactive
    self.active=false
  end

  def set_active
    self.active=true
  end

  validates :name, presence: true ,uniqueness: true, length: {minimum:2,maximum:100}
  validates :address, length: {minimum:0,maximum:1024}
  validates :location,length: {minimum:0,maximum:100}
  VALID_PHONE_REGEX = /\A\+?[0-9\-\s\(\)\/{ext:}]*\z/
  #validates :phone, format: {with: VALID_PHONE_REGEX, message: "Phone can be Numerals, (, ), / (For multiple numbers), Space , - , ext: (For extension). + symbol allowed at beggining"}
  VALID_URL_REGEX = /\A[[a-z\d\-.\/:]+\.[a-z]+]?\z/i
  #validates :url, format: {with: VALID_URL_REGEX}
end
