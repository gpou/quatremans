require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path } 
    let(:heading)    { 'Nina' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Quisom page" do
    before { visit quisom_path } 
    let(:heading)    { 'Qui som?' }
    let(:page_title) { 'Qui som?' }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contacte_path } 
    let(:heading)    { 'Contacte' }
    let(:page_title) { 'Contacte' }
    it_should_behave_like "all static pages"
  end

  describe "Products page" do
    before { visit products_path } 
    let(:heading)    { 'All products' }
    let(:page_title) { 'All products' }
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Qui som?"
    page.should have_selector 'title', text: full_title('Qui som?')
    click_link "Contacte"
    page.should have_selector 'title', text: full_title('Contacte')
    click_link "Productes"
    page.should have_selector 'title', text: full_title('All products')
    click_link "Nina"
    page.should have_selector 'title', text: full_title('')
  end
end