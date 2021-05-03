require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'Save correctly when all fields are filled out' do
      @category = Category.create(name: 'test')
      @product = Product.create(name: 'Test Product', price: 10, quantity: 10, category: @category)
      expect(@product.errors.full_messages.size).to be(0)
    end

    it 'returns an error when "name" is missing' do
      @category = Category.create(name: 'test')
      @product = Product.create(price: 10, quantity: 10, category: @category)
      expect(@product.errors.full_messages).to include('Name can\'t be blank')
    end

    it 'returns an error when "price" is missing' do
      @category = Category.create(name: 'test')
      @product = Product.create(name: 'Test Product', quantity: 10, category: @category)
      expect(@product.errors.full_messages).to include('Price can\'t be blank')
    end

    it 'returns an error when "quantity" is missing' do
      @category = Category.create(name: 'test')
      @product = Product.create(name: 'Test Product', price: 10, category: @category)
      expect(@product.errors.full_messages).to include('Quantity can\'t be blank')
    end

    it 'returns an error when "cateogry" is missing' do
      @product = Product.create(name: 'Test Product', price: 10, quantity: 10)
      expect(@product.errors.full_messages).to include('Category can\'t be blank')
    end
  end
end