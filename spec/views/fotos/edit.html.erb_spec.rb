require 'spec_helper'

describe "fotos/edit" do
  before(:each) do
    @foto = assign(:foto, stub_model(Foto,
      :nom => "MyString"
    ))
  end

  it "renders the edit foto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fotos_path(@foto), :method => "post" do
      assert_select "input#foto_nom", :name => "foto[nom]"
    end
  end
end
