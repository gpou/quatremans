require 'spec_helper'

describe "Product" do
  subject { page }

  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin }

  describe "index" do
    before do
      FactoryGirl.create(:product)
      FactoryGirl.create(:product)
      visit products_path
    end
    it { should have_selector('title', text: 'All products') }
    it { should have_selector('h1',    text: 'All products') }

    describe "should have links to all products" do
      Product.all.each do |prod|
        it { should have_link(prod.name, href: product_path(prod)) }
        it { should have_link("modificar", href: edit_product_path(prod)) }
        it { should have_link("eliminar", href: product_path(prod)) }
      end
    end
  end

  describe "show" do
    let(:product) { FactoryGirl.create(:product) }
    before do
      visit product_path(product)
    end

    describe "page" do
      it { should have_selector('h1',    text: product.name) }
      it { should have_selector('title', text: product.name) }
      it { should have_link('Modifica', href: edit_product_path(product)) }
      it { should have_link('Elimina', href: product_path(product)) }
    end
  end

  describe "creation" do
    before { visit new_product_path }

    describe "page" do
      it { should have_selector('h1',    text: "Afegeix un producte") }
      it { should have_selector('title', text: "Afegeix un producte") }
      it { should have_link('Cancela', href: products_path) }
    end

    describe "without name" do
      before do
        fill_in 'product_price', with: 10
      end
      it "should not create a product" do
        expect { click_button "Guarda" }.not_to change(Product, :count)
      end

      describe "error messages" do
        before { click_button "Guarda" }
        it { should have_content('error') } 
      end
    end

    describe "without price" do
      before do
        fill_in 'product_name', with: "Hola"
      end
      it "should not create a product" do
        expect { click_button "Guarda" }.not_to change(Product, :count)
      end

      describe "error messages" do
        before { click_button "Guarda" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do
      before do
        fill_in 'product_name', with: "Lorem ipsum"
        fill_in 'product_price', with: 10
      end
      it "should create a product" do
        expect { click_button "Guarda" }.to change(Product, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:product) { FactoryGirl.create(:product) }
    before do
      visit edit_product_path(product)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Modifica el producte") }
      it { should have_selector('title', text: "Modifica el producte") }
      it { should have_link('Elimina', href: product_path(product)) }
      it { should have_link('Cancela', href: products_path) }
    end

    describe "with invalid information" do
      before do
        fill_in "Name", with: ""
        click_button "Guarda"
      end
      it { should have_content('error') } 
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_price) { 40 }
      before do
        fill_in "Name",             with: new_name
        fill_in "Price",            with: new_price
        click_button "Guarda"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { product.reload.name.should  == new_name }
      specify { product.reload.price.should == new_price }
    end
  end

  describe "destruction" do
    before do
      FactoryGirl.create(:product)
      FactoryGirl.create(:product)
      visit products_path
    end

    it "should delete a product" do
      expect { click_link "eliminar" }.to change(Product, :count).by(-1)
    end
  end  
end
