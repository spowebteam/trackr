require 'spec_helper'

describe "Statics" do
  describe "About page" do
    it "should have the content 'About'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit about_path
      page.should have_content ('About')
    end
    it "should have proper title 'About | Trackr'" do
    	visit about_path
    	page.should have_selector('title',:text=>"About | Trackr")
    end
  end
  describe "Contact page" do
    it "should have the content 'Contact'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit contact_path
      page.should have_content ('Contact')
      page.should have_content ("abhi+trackr@manyu.in")
    end
    it "should have proper title 'About | Trackr'" do
    	visit contact_path
    	page.should have_selector('title',:text=>"Contact | Trackr")
    end
  end
  describe "Home page" do
  	it "should have the content 'Home'" do
  		visit root_path
  		page.should have_selector('title',:text=>"Home | Trackr")
  	end
  end

  
end
 