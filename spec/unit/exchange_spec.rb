require 'rails_helper'

RSpec.describe Exchange, type: :model do
  let(:user) { User.create(firstname: 'John', lastname: 'Doe', email: 'john@example.com', password: 'password123') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      exchange = Exchange.new(name: 'Test Exchange', amount: 2000, author_id: user.id)
      expect(exchange).to be_valid
    end

    it 'is invalid if name is null' do
      exchange = Exchange.new(amount: 2000, author_id: user.id)
      expect(exchange).to_not be_valid
    end

    it 'is invalid if amount is not a number' do
      exchange = Exchange.new(name: 'Test Exchange', amount: 'sare', author_id: user.id)
      expect(exchange).to_not be_valid
    end

    it 'is invalid if amount is less than 0' do
      exchange = Exchange.new(name: 'Test Exchange', amount: -1, author_id: user.id)
      expect(exchange).to_not be_valid
    end

    it 'is invalid if author_id is not present' do
      exchange = Exchange.new(name: 'Test Exchange', amount: 2000)
      expect(exchange).to_not be_valid
    end
  end
end
