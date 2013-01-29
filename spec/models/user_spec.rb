# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  level      :integer
#  phone      :string(255)
#  identifier :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",level: 0,phone:"+918960436693",identifier: "11111002")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:level) }
  it { should respond_to(:identifier) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is really long" do
    before {@user.name = "a" *101}
    it {should_not be_valid }
  end

  describe "when name is too short" do
    before {@user.name = "a"}
    it {should_not be_valid}
  end

  describe "when email is invalid" do
    it "should be invalid" do
        addresses=%w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalidAddress|
            @user.email= invalidAddress
            @user.should_not be_valid
        end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn a@9gag.eu some_us.er+df@ft.her-df.in]
      addresses.each do |validAddress|
        @user.email = validAddress
        @user.should be_valid
      end      
    end
  end

  describe "when email is not unique" do
    before do
        userSameEmail=@user.dup
        userSameEmail.identifier="110022"
        userSameEmail.save
    end

    it {should_not be_valid}
  end

  describe "when identifier is not unique" do
    before do
        userSameEmail=@user.dup
        userSameEmail.email="manyu@cse.iitk.ac.in"
        userSameEmail.save
    end

    it {should_not be_valid}
  end

  describe "when phone number is valid" do
    it "should be valid" do
        phoneNumbers=["","+91 1234","(808) 23 234-23","+1 (234) 23-234-234"]
        phoneNumbers.each do |validNumber|
            @user.phone = validNumber
            @user.should be_valid
        end 
    end
  end

  describe "when phone number is invalid" do
    it "should be invalid" do
        phoneNumbers=["some","+91 234 some","/324"]
        phoneNumbers.each do |invalidNumber|
            @user.phone=invalidNumber
            @user.should_not be_valid
        end
    end
  end


end