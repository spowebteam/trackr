class Log < ActiveRecord::Base
  attr_accessible :contact_id, :content, :status, :user_id, :company_id

  attr_reader :user,:company,:contact

  belongs_to :company
  belongs_to :user
  belongs_to :contact

  validates :content, presence: true, length: {minimum:2,maximum:1024}
  validates :company_id, presence: true
end
