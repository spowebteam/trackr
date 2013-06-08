require 'spec_helper'

describe "contacts/show" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :name => "Name",
      :designation => "Designation",
      :landline => "Landline",
      :mobile => "Mobile",
      :email => "Email",
      :address => "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Designation/)
    rendered.should match(/Landline/)
    rendered.should match(/Mobile/)
    rendered.should match(/Email/)
    rendered.should match(/Address/)
  end
end
