require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h2',    text: 'Sign In') }
    it { should have_selector('title', text: 'Sign In') }

    describe "with invalid information" do
    	before { click_button "Sign In"}

    	it {should have_selector('title', text:'Sign In')}
    	it {should have_selector('div.alert.alert-error', text:'Invalid')}
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
    end
  end
end
