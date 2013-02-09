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
    	
    	describe "after visiting another page" do
    		before {click_link "Trackr"}
    		it {should_not have_selector('div.alert.alert-error')}
    	end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user
}      

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile',  href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
    end

    
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        describe "after sigining in" do
          it "should render the desired protected page" do
            page.should have_selector('title',text:'Edit')
          end
        end


      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before do
            sign_in user 
            visit users_path
          end
          it {should have_selector('title',text:'Sign in')}
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com",identifier: "someonehere") } 

      before {sign_in user}

      describe "visit wrong user page" do
        before{ visit edit_user_path(wrong_user)}
        it {should_not have_selector('title',text:'Edit')}
      end

      describe "submitting a PUT request to the user" do
        before{put user_path(wrong_user)}
        specify{response.should redirect_to(root_path)}
      end

    end
  end
end
