require 'lib/backery.rb'
require 'lib/order.rb'
require 'lib/order_breakdown.rb'
require 'lib/order_parser.rb'
require 'lib/product.rb'

vegemite_scroll = Product.new('Vegemite Scroll', 'VS5')
blueberry_muffin = Product.new('Blueberry Muffin', 'MB11')
croissant = Product.new('Croissant', 'CF')

backery = Backery.new
backery.add_package(vegemite_scroll, 3, 6.99)
backery.add_package(vegemite_scroll, 5, 8.99)
backery.add_package(blueberry_muffin, 2, 9.95)
backery.add_package(blueberry_muffin, 5, 16.95)
backery.add_package(blueberry_muffin, 8, 24.95)
backery.add_package(croissant, 3, 5.95)
backery.add_package(croissant, 5, 9.95)
backery.add_package(croissant, 9, 16.99)

order_breakdown = OrderBreackdown.new(backery)
order_parser = OrderParser.new

ARGF.each_line do |line|
  begin
    order_input = order_parser.parse(line)
    order = order_breakdown.breakdown(order_input.code, order_input.quantity)
    p order.to_s
  rescue StandardError => e
    p e.message
  end
end
