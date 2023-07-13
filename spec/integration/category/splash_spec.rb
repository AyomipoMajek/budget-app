require 'rails_helper'

RSpec.describe Category, type: :system do
  describe 'splash page' do
    before :each do
      visit root_path
    end

    it 'displays the welcome message' do
      expect(page).to have_content 'Welcome to Your Budget App'
    end

    it 'displays the app description' do
      expect(page).to have_content 'Take control of your finances with our budgeting app. Easily track your expenses, set savings goals, and achieve financial freedom'
    end

    it 'displays the "Log in" and "Sign up" buttons if user is not signed in' do
      expect(page).to have_link('Log in', href: categories_path)
      expect(page).to have_link('Sign up', href: new_user_registration_path)
    end
  end
end
