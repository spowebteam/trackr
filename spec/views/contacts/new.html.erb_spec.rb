require 'spec_helper'

describe "contacts/new" do
  before(:each) do
    assign(:contact, stub_model(Contact,
      :name => "MyString",
      :designation => "MyString",
      :landline => "MyString",
      :mobile => "MyString",
      :email => "MyString",
      :address => "MyString"
    ).as_new_record)
  end

  it "renders new contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contacts_path, :method => "post" do
      assert_select "input#contact_name", :name => "contact[name]"
      assert_select "input#contact_designation", :name => "contact[designation]"
      assert_select "input#contact_landline", :name => "contact[landline]"
      assert_select "input#contact_mobile", :name => "contact[mobile]"
      assert_select "input#contact_email", :name => "contact[email]"
      assert_select "input#contact_address", :name => "contact[address]"
    end
  end
end
