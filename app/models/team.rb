class Team < ActiveRecord::Base
  attr_accessible :description, :name,:user_tokens
  has_and_belongs_to_many :users
  attr_reader :user_tokens

  validates :name, presence: true , length: {minimum:2,maximum:100}
  validates :description, length: {maximum:500}

  def user_tokens=(ids)
  	self.user_ids=ids.split(",")
  end
end
