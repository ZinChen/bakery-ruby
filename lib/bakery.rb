class Bakery
  InvalidProduct = Class.new(StandardError)

  attr_reader :packages

  def initialize
    @packages = []
  end

  def add_package(product, quantity, price)
    raise(InvalidProduct, product) unless product.instance_of?(Product)

    @packages << {
      product: product,
      quantity: Integer(quantity),
      price: Float(price)
    }
  end

  def packages_by_code(code)
    @packages.select { |p| p[:product].code == code }
  end
end
