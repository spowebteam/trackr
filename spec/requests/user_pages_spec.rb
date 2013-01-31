require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup" do
    before { visit signup_path }

    let(:submit) {"Signup"}

    describe "with invalid info" do
        it "should not create a user" do
            expect {click_button submit}.not_to change(User, :count)
        end
    end

    describe "with valid info" do
        before do
            fill_in "Name",             with: "Example User"
            fill_in "Email",            with: "example@manyu.in"
            fill_in "Password",         with: "foobar"
            fill_in "Confirmation",     with: "foobar"
            fill_in "Phone",            with: "+1 (12) 234 23"
            fill_in "Identifier",       with: "amanyu"       
        end

        it "should create a user" do
            expect {click_button submit}.to change(User, :count).by(1)
        end
    end
    
  end

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}
    before { visit user_path(user)}

    it {should have_selector('h1', text: user.name)}
    it {should have_selector('title', text: user.name)}
  end


end