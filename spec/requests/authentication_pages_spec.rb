require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Identificacio') }
    it { should have_selector('title', text: 'Identificacio') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Connectar" }

      it { should have_selector('title', text: 'Identificacio') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should_not have_link('Administracio') }
      it { should have_link('Desconnectar', href: signout_path) }
      it { should_not have_link('Connectar', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Desconnectar" }
        it { should_not have_link('Administracio') }
        it { should have_link('Connectar') }
        it { should_not have_link('Desconnectar') }
      end
    end

    describe "with admin credentials" do
      let(:admin) { FactoryGirl.create(:admin) }
      before { sign_in admin }

      it do
        should have_selector("a.dropdown-toggle")
      end
      it { should have_link('Administracio') }

      describe "followed by signout" do
        before { click_link "Desconnectar" }
        it { should_not have_link('Administracio') }
      end
    end    
  end

  describe "authorization" do

    describe "as non-admin user" do
      let(:product) { FactoryGirl.create(:product) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "in the Products controller" do
        describe "visiting the products index" do
          before { visit products_path }
          it { should have_selector('title', text: 'All products') }
        end

        describe "visiting the new page" do
          before { visit new_product_path }
          it { should have_selector('title', text: 'Identificacio') }
        end

        describe "submitting to the create action" do
          before { post products_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the edit page" do
          before { visit edit_product_path(product) }
          it { should have_selector('title', text: 'Identificacio') }
        end

        describe "submitting to the update action" do
          before { put product_path(product) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting a DELETE request to the Products#destroy action" do
          before { delete product_path(product) }
          specify { response.should redirect_to(signin_path) }        
        end
      end

    end
  end
end
