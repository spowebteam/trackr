class Team < ActiveRecord::Base
  attr_accessible :description, :name
  has_and_belongs_to_many :users

  validates :name, presence: true , length: {minimum:2,maximum:100}
  validates :description, length: {maximum:500}

end
