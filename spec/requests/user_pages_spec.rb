require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do 
      sign_in FactoryGirl.create(:user)
      visit users_path
    end 



    it { should have_selector('title', text:'Users')}
    it {should have_selector('h1',text:'User List')}

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('td',text: user.name)
      end
    end

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('td', text: user.name)
        end
      end
    end

    

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
    before do
      sign_in user 
      visit user_path(user)
    end

    it {should have_selector('h1', text: user.name)}
    it {should have_selector('title', text: user.name)}
  end

  describe "edit" do

    let(:user) {FactoryGirl.create(:user)}
    before do
        sign_in user
        visit edit_user_path(user)
    end

    describe "page" do
        it { should have_selector('h1', text:"Update your profile")}
        it { should have_selector('title', text: "Edit")}
    end

    describe "with invalid information" do
        before{click_button "Update"}
        it {should have_content('error')}
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Update"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign Out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email } 
    end
  end





end