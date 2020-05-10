require 'product'
require 'bakery'
require 'order'
require 'order_breakdown'

describe OrderBreakdown do
  let(:vegemite_scroll) { Product.new('Vegemite Scroll', 'VS5') }
  let(:blueberry_muffin) { Product.new('Blueberry Muffin', 'MB11') }
  let(:croissant) { Product.new('Croissant', 'CF') }
  let(:bakery) { Bakery.new }
  let(:order_breakdown) { OrderBreakdown.new(bakery) }

  describe '#breakdown_for_packages' do
    it 'should calculate result for 10 VS5s' do
      bakery.add_package(vegemite_scroll, 3, 6.99)
      bakery.add_package(vegemite_scroll, 5, 8.99)
      bakery.add_package(croissant, 3, 5.95)

      order = order_breakdown.breakdown('VS5', 10)
      packages_count = order.result.map { |r| r[:count] }
      expect(packages_count).to eq([2, 0])
    end

    it 'should calculate result for 14 MB11s' do
      bakery.add_package(blueberry_muffin, 2, 9.95)
      bakery.add_package(blueberry_muffin, 5, 16.95)
      bakery.add_package(blueberry_muffin, 8, 24.95)
      bakery.add_package(croissant, 3, 5.95)

      order = order_breakdown.breakdown('MB11', 14)
      packages_count = order.result.map { |r| r[:count] }
      expect(packages_count).to eq([1, 0, 3])
    end

    it 'should calculate result for 13 CFs' do
      bakery.add_package(croissant, 3, 5.95)
      bakery.add_package(croissant, 5, 9.95)
      bakery.add_package(croissant, 9, 16.99)
      bakery.add_package(vegemite_scroll, 3, 6.99)

      order = order_breakdown.breakdown('CF', 13)
      packages_count = order.result.map { |r| r[:count] }
      expect(packages_count).to eq([0, 2, 1])
    end

    it 'should raise an error for non existed code' do
      bakery.add_package(croissant, 3, 5.95)
      bakery.add_package(croissant, 5, 9.95)

      expect { order_breakdown.breakdown('NONE', 13) }
        .to raise_exception(StandardError)
    end

    it 'should raise an error for non breakable quantity' do
      bakery.add_package(croissant, 3, 5.95)
      bakery.add_package(croissant, 5, 9.95)
      bakery.add_package(croissant, 9, 16.99)

      expect { order_breakdown.breakdown('CF', 7) }
        .to raise_exception(StandardError)
    end
  end
end
