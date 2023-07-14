require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(firstname: 'John', lastname: 'Doe', email: 'john@example.com', password: 'password123')
      expect(user).to be_valid
    end

    it 'is invalid if firstname is not present' do
      user = User.new(lastname: 'Doe', email: 'john@example.com', password: 'password123')
      expect(user).to_not be_valid
    end

    it 'is invalid if lastname is not present' do
      user = User.new(firstname: 'John', email: 'john@example.com', password: 'password123')
      expect(user).to_not be_valid
    end
  end
end
