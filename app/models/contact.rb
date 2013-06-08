class Contact < ActiveRecord::Base
  attr_accessible :address, :designation, :email, :landline, :mobile, :name
end
