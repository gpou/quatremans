require 'spec_helper'

describe "fotos/index" do
  before(:each) do
    assign(:fotos, [
      stub_model(Foto,
        :nom => "Nom"
      ),
      stub_model(Foto,
        :nom => "Nom"
      )
    ])
  end

  it "renders a list of fotos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nom".to_s, :count => 2
  end
end
