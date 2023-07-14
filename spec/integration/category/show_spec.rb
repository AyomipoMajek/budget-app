require 'rails_helper'

RSpec.describe Category, type: :system do
  describe 'show view' do
    before :each do
      @user = User.create(firstname: 'John', lastname: 'Doe', email: 'john@example.com', password: 'password123')
      @file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'red_vibr.png'), 'image/png')
      @category = Category.create(name: 'Test Category', author_id: @user.id)
      @category.icon.attach(@file)
      @transaction = Exchange.create(name: 'Test Exchange 1', amount: 200, author_id: @user.id)
      @transactionone = Exchange.create(name: 'Test Exchange 2', amount: 400, author_id: @user.id)
      @transactiontwo = Exchange.create(name: 'Test Exchange 3', amount: 600, author_id: @user.id)
      CategoryExchange.create(category_id: @category.id, exchange_id: @transaction.id)
      CategoryExchange.create(category_id: @category.id, exchange_id: @transactionone.id)
      CategoryExchange.create(category_id: @category.id, exchange_id: @transactiontwo.id)

      visit category_path(@category.id)
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Log in'
    end

    it 'displays the create Transaction form' do
      click_on 'Add Transaction'
      expect(page).to have_content('Create Transaction')
    end

    it 'displays the "Add Transaction" text' do
      expect(page).to have_content('Add Transaction')
    end

    it 'returns to the category index page' do
      click_on 'back'
      expect(page).to have_content('CATEGORY')
    end

    it 'displays all exchange names' do
      @category.exchanges.each do |exchange|
        expect(page).to have_content(exchange.name)
      end
    end

    it 'displays the total amount of transactions' do
      total = @category.exchanges.sum(:amount)
      expect(page).to have_content("$#{total}")
    end

    it 'displays all exchange amounts' do
      @category.exchanges.each do |exchange|
        expect(page).to have_content("$#{exchange.amount}")
      end
    end

    it 'logs the user out of the app' do
      click_on 'sign out'
      expect(page).to have_content('Welcome to Your Budget App')
    end
  end
end
