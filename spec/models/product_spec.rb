require 'rails_helper'

# Test that the expect error is found within the .errors.full_messages array

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid with name, price, quatity and category" do
      @category = Category.new(:name => 'test category')
      @category.save
      @product = Product.new(
        :name => "test name", 
        :price_cents => 1000,
        :quantity => 6,
        :category_id => @category.id
        )
      expect(@product.save).to eq(true)
    end

    it "is not valid without name" do
      @category = Category.new(:name => 'test category')
      @category.save
      @product = Product.new(
        :name => nil, 
        :price_cents => 1000,
        :quantity => 6,
        :category_id => @category.id
        )
        expect(@product.save).to eq(false)
        expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

    it "is not valid without price" do
      @category = Category.new(:name => 'test category')
      @category.save
      @product = Product.new(
        :name => "test name", 
        :price_cents => nil,
        :quantity => 6,
        :category_id => @category.id
        )
      expect(@product.save).to eq(false)
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it "is not valid without quantity" do
      @category = Category.new(:name => 'test category')
      @category.save
      @product = Product.new(
        :name => "test name", 
        :price_cents => 1000,
        :quantity => nil,
        :category_id => @category.id
        )
      expect(@product.save).to eq(false)
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end

    it "is not valid without category" do
      @product = Product.new(
        :name => "test name", 
        :price_cents => 1000,
        :quantity => 6,
        :category_id => nil
        )
      expect(@product.save).to eq(false)
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end
  end
end
