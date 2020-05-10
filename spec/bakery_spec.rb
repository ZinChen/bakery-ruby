require 'bakery'

describe Bakery do
  let(:product_cf) { Product.new('Croissant', 'CF') }
  let(:product_mb) { Product.new('Blueberry Muffin', 'MB11') }
  let(:bakery) { Bakery.new }

  describe '#add_package' do
    it 'should add package' do
      bakery.add_package(product_cf, 5, 5.99)
      expect(bakery.packages)
        .to include({
                      product: product_cf,
                      quantity: 5,
                      price: 5.99
                    })
    end

    it 'should raise error on wrong product' do
      expect { bakery.add_package(nil, 5, 5.99) }
        .to raise_exception(StandardError)
    end

    it 'should raise error on wrong quantity' do
      expect { bakery.add_package(product_cf, 'wrong', 5.99) }
        .to raise_exception(StandardError)
    end

    it 'should raise error on wrong price' do
      expect { bakery.add_package(product_cf, 5, nil) }
        .to raise_exception(StandardError)
    end
  end

  describe '#packages_by_code' do
    it 'should return all packages by code' do
      bakery.add_package(product_cf, 5, 5.99)
      bakery.add_package(product_mb, 3, 7.99)
      expect(bakery.packages_by_code('CF').length)
        .to eq(1)
    end
  end
end
