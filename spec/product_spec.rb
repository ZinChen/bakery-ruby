require 'product'

describe Product do
  let(:product) { Product.new('Croissant', 'CF') }

  describe '.name' do
    subject { product.name }

    it { is_expected.to eq('Croissant') }
  end

  describe '.code' do
    subject { product.code }

    it { is_expected.to eq('CF') }
  end
end
