require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(firstname: 'John', lastname: 'Doe', email: 'john@example.com', password: 'password123') }
  let(:file) { fixture_file_upload('red_vibr.png', 'image/png') }
  let(:category) { Category.new(name: 'Test Category', author_id: user.id) }

  describe 'validations' do
    before { category.icon.attach(file) }

    it 'should create category' do
      expect(category).to be_valid
    end

    it 'should be invalid if name is not present' do
      category.name = nil
      expect(category).not_to be_valid
    end

    it 'should be invalid if author_id is not present' do
      category.author_id = nil
      expect(category).not_to be_valid
    end
  end
end
