require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: I18n.t('sessions.authentication')) }
    it { should have_selector('title', text: I18n.t('sessions.authentication')) }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button I18n.t('sessions.signin') }

      it { should have_selector('title', text: I18n.t('sessions.authentication')) }
      it { should have_selector('div.alert.alert-error') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should_not have_link(I18n.t('sessions.authentication')) }
      it { should have_link(I18n.t('sessions.signout'), href: signout_path) }
      it { should_not have_link(I18n.t('sessions.signin'), href: signin_path) }

      describe "followed by signout" do
        before { click_link I18n.t('sessions.signout') }
        it { should_not have_link(I18n.t('sessions.authentication')) }
        it { should have_link(I18n.t('sessions.signin')) }
        it { should_not have_link(I18n.t('sessions.signout')) }
      end
    end

    describe "with admin credentials" do
      let(:admin) { FactoryGirl.create(:admin) }
      before { sign_in admin }

      it { should have_selector("a.dropdown-toggle") }
      it { should have_link(I18n.t('admin.title')) }

      describe "followed by signout" do
        before { click_link I18n.t('sessions.signout') }
        it { should_not have_link(I18n.t('sessions.authentication')) }
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
          it { should have_selector('title', text: I18n.t('products.index.title')) }
        end

        describe "visiting the new page" do
          before { visit new_product_path }
          it { should have_selector('title', text: I18n.t('sessions.authentication')) }
        end

        describe "submitting to the create action" do
          before { post products_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the edit page" do
          before { visit edit_product_path(product) }
          it { should have_selector('title', text: I18n.t('sessions.authentication')) }
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
