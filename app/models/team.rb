class Team < ActiveRecord::Base
  attr_accessible :description, :name,:user_tokens
  has_and_belongs_to_many :users
  has_and_belongs_to_many :companies
  attr_reader :user_tokens
  attr_reader :company_tokens
  
  validates :name, presence: true , length: {minimum:2,maximum:100}
  validates :description, length: {maximum:500}

  def set_single
    self.single=true
  end

  def single?
    self.single
  end
  def user_tokens=(ids)
  	self.user_ids=ids.split(",")
  end

  def company_tokens=(ids)
  	self.company_ids=ids.split(",")
  end
end
