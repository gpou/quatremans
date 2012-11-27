require 'spec_helper'

describe "fotos/new" do
  before(:each) do
    assign(:foto, stub_model(Foto,
      :nom => "MyString"
    ).as_new_record)
  end

  it "renders new foto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fotos_path, :method => "post" do
      assert_select "input#foto_nom", :name => "foto[nom]"
    end
  end
end