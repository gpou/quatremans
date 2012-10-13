require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path } 
    let(:heading)    { I18n.t('site_title') }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '|' }
  end

  describe "Quisom page" do
    before { visit quisom_path } 
    let(:heading)    { I18n.t('static_pages.quisom.title') }
    let(:page_title) { I18n.t('static_pages.quisom.title') }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contacte_path } 
    let(:heading)    { I18n.t('static_pages.contacte.title') }
    let(:page_title) { I18n.t('static_pages.contacte.title') }
    it_should_behave_like "all static pages"
  end

  describe "Products page" do
    before { visit products_path } 
    let(:heading)    { I18n.t('products.index.title') }
    let(:page_title) { I18n.t('products.index.title') }
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link I18n.t('static_pages.quisom.title')
    page.should have_selector 'title', text: full_title(I18n.t('static_pages.quisom.title'))
    click_link I18n.t('static_pages.contacte.title')
    page.should have_selector 'title', text: full_title(I18n.t('static_pages.contacte.title'))
    click_link I18n.t('products.index.title')
    page.should have_selector 'title', text: full_title(I18n.t('products.index.title'))
    click_link I18n.t('site_title')
    page.should have_selector 'title', text: full_title('')
  end
end