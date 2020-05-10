require 'product'
require 'backery'
require 'order'
require 'order_breakdown'

describe OrderBreakdown do
  let(:vegemite_scroll) { Product.new('Vegemite Scroll', 'VS5') }
  let(:blueberry_muffin) { Product.new('Blueberry Muffin', 'MB11') }
  let(:croissant) { Product.new('Croissant', 'CF') }
  let(:backery) { Backery.new }
  let(:order_breakdown) { OrderBreakdown.new(backery) }

  describe '#breakdown_for_packages' do
    it 'should calculate result for 10 VS5s' do
      backery.add_package(vegemite_scroll, 3, 6.99)
      backery.add_package(vegemite_scroll, 5, 8.99)
      backery.add_package(croissant, 3, 5.95)

      order = order_breakdown.breakdown('VS5', 10)
      packages_count = order.result.map{ |r| r[:count] }
      expect(packages_count).to eq([2, 0])
    end

    it 'should calculate result for 14 MB11s' do
      backery.add_package(blueberry_muffin, 2, 9.95)
      backery.add_package(blueberry_muffin, 5, 16.95)
      backery.add_package(blueberry_muffin, 8, 24.95)
      backery.add_package(croissant, 3, 5.95)

      order = order_breakdown.breakdown('MB11', 14)
      packages_count = order.result.map{ |r| r[:count] }
      expect(packages_count).to eq([1, 0, 3])
    end

    it 'should calculate result for 13 CFs' do
      backery.add_package(croissant, 3, 5.95)
      backery.add_package(croissant, 5, 9.95)
      backery.add_package(croissant, 9, 16.99)
      backery.add_package(vegemite_scroll, 3, 6.99)

      order = order_breakdown.breakdown('CF', 13)
      packages_count = order.result.map{ |r| r[:count] }
      expect(packages_count).to eq([0, 2, 1])
    end

    it 'should return nil for non existed code' do
      backery.add_package(croissant, 3, 5.95)
      backery.add_package(croissant, 5, 9.95)

      order = order_breakdown.breakdown('NONE', 13)
      expect(order).to eq(nil)
    end

    it 'should return nil for non breakable quantity' do
      backery.add_package(croissant, 3, 5.95)
      backery.add_package(croissant, 5, 9.95)
      backery.add_package(croissant, 9, 16.99)

      order = order_breakdown.breakdown('CF', 7)
      expect(order).to eq(nil)
    end
  end
end
