require 'order'

describe Order do
  let(:package) { { quantity: 5, price: 9.95 } }
  let(:package_2) { { quantity: 3, price: 5.95 } }
  let(:order) { described_class.new }

  describe '#add_package_result' do
    it 'should add package' do
      order.add_package_result({ package: package, count: 3 })
      expect(order.result.first)
        .to eq({
                 package: package,
                 count: 3
               })
    end
  end

  describe '#pop_package_result' do
    it 'should pop package' do
      order.add_package_result({ package: package, count: 3 })
      order.pop_package_result
      expect(order.result.length).to eq(0)
    end
  end

  describe '#total_quantity' do
    it 'should count total quantity of product' do
      order.add_package_result({ package: package, count: 3 })
      expect(order.total_quantity)
        .to eq(15)
    end

    it 'should count 0 with no packages' do
      expect(order.total_quantity)
        .to eq(0)
    end
  end

  describe '#to_s' do
    it 'should print formatted order' do
      order.add_package_result({ package: package, count: 2 })
      order.add_package_result({ package: package_2, count: 1 })

      expect(order.to_s).to eq(
        "$25.85\n" \
        "2 x 5 $9.95\n" \
        '1 x 3 $5.95'
      )
    end
  end
end
