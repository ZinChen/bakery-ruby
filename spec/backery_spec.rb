require 'backery'

describe Backery do
  let(:product_cf) { Product.new('Croissant', 'CF') }
  let(:product_mb) { Product.new('Blueberry Muffin', 'MB11') }
  let(:backery) { Backery.new }

  describe '#add_package' do
    it 'should add package' do
      backery.add_package(product_cf, 5, 5.99)
      expect(backery.packages).to include({
        product: product_cf,
        quantity: 5,
        price:5.99
      })
    end

    it 'should raise error on wrong product' do
      expect { backery.add_package(nil, 5, 5.99) }
        .to raise_exception(StandardError)
    end

    it 'should raise error on wrong quantity' do
      expect { backery.add_package(product_cf, 'wrong', 5.99) }
        .to raise_exception(StandardError)
    end

    it 'should raise error on wrong price' do
      expect { backery.add_package(product_cf, 5, nil) }
        .to raise_exception(StandardError)
    end

  end

  describe '#packages_by_code' do
    it 'should return all packages by code' do
      backery.add_package(product_cf, 5, 5.99)
      backery.add_package(product_mb, 3, 7.99)
      expect(backery.packages_by_code('CF').length)
        .to eq(1)
    end
  end
end
