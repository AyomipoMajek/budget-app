require 'rails_helper'

RSpec.describe Category, type: :system do
  describe 'index view' do
    let(:user) { User.create(firstname: 'John', lastname: 'Doe', email: 'john@example.com', password: 'password123') }
    let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'red_vibr.png'), 'image/png') }

    before :each do
      @category = Category.create(name: 'Test Category', author_id: user.id)
      @transaction = Exchange.create(name: 'Test Exchange', amount: 200, author_id: user.id)
      @category.icon.attach(file)
      CategoryExchange.create(category_id: @category.id, exchange_id: @transaction.id)

      visit categories_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    it 'displays the create category form' do
      click_on 'Add category'
      expect(page).to have_content('NEW CATEGORY')
    end

    it 'displays the category name' do
      expect(page).to have_content('CATEGORY')
    end

    it 'displays the "Add category" text' do
      expect(page).to have_content('Add category')
    end

    it 'returns to the category index page' do
      click_on 'back'
      expect(page).to have_content('CATEGORY')
    end

    it 'displays all categories' do
      expect(page).to have_content(@category.name)
    end

    it 'displays the total amount of transactions for each category' do
      total = @category.exchanges.sum(:amount)
      expect(page).to have_content("$#{total}")
    end

    it 'removes all categories' do
      click_on "remove #{@category.name}"
      expect(page).to_not have_content(@category.name)
    end

    it 'navigates to each category details page' do
      click_on @category.name
      expect(page).to have_content('Add Transaction')
      click_on 'back'
    end

    it 'logs the user out of the app' do
      click_on 'sign out'
      expect(page).to have_content('Welcome to Your Budget App')
    end
  end
end
