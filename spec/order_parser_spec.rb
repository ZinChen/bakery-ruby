require 'order_parser'

describe OrderParser do
  let(:order_parser) { OrderParser.new }

  describe '.code' do
    it 'should return proper code' do
      order_parser.parse('13 CF')
      expect(order_parser.code).to eq('CF')
    end
  end

  describe '.quantity' do
    it 'should return proper quantity' do
      order_parser.parse('13 CF')
      expect(order_parser.quantity).to eq(13)
    end
  end

  describe '#parse' do
    it 'should raise exception' do
      expect { OrderParser.parse('wrong input') }
        .to raise_exception(StandardError)
    end
  end
end
