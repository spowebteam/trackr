require 'spec_helper'

describe "contacts/index" do
  before(:each) do
    assign(:contacts, [
      stub_model(Contact,
        :name => "Name",
        :designation => "Designation",
        :landline => "Landline",
        :mobile => "Mobile",
        :email => "Email",
        :address => "Address"
      ),
      stub_model(Contact,
        :name => "Name",
        :designation => "Designation",
        :landline => "Landline",
        :mobile => "Mobile",
        :email => "Email",
        :address => "Address"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Designation".to_s, :count => 2
    assert_select "tr>td", :text => "Landline".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
  end
end
