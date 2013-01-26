require 'spec_helper'

describe "Statics" do
  describe "About page" do
    it "should have the content 'About'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static/about'
      page.should have_content ('About')
    end
    it "should have proper title 'About | Trackr'" do
    	visit '/static/about'
    	page.should have_selector('title',:text=>"About | Trackr")
    end
  end
end
