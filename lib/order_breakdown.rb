class OrderBreakdown
  attr_reader :bakery, :order, :target_quantity

  def initialize(bakery)
    @bakery = bakery
    @order = nil
    @target_quantity = nil
  end

  def breakdown(code, quantity)
    @order = Order.new
    @target_quantity = quantity

    bakery_packages = bakery.packages_by_code(code).sort_by { |p| -p[:quantity] }

    raise StandardError, 'Wrong product code' if bakery_packages.empty?

    breakdown_for_packages(bakery_packages, quantity) unless bakery_packages.empty?

    raise StandardError, 'No suitable packages' unless @order.total_quantity.positive?

    @order
  end

  private

  def breakdown_for_packages(bakery_packages, quantity)
    package = bakery_packages.first
    package_count = quantity / package[:quantity]

    while package_count >= 0
      process_packages(bakery_packages, quantity, package_count) unless bakery_packages.empty?

      break if @order.total_quantity == @target_quantity

      @order.pop_package_result
      package_count -= 1
    end
  end

  def process_packages(bakery_packages, quantity, package_count)
    package = bakery_packages.first
    quantity_left = quantity - package[:quantity] * package_count

    @order.add_package_result({
      package: package,
      count: package_count
    })

    breakdown_for_packages(bakery_packages.drop(1), quantity_left) if bakery_packages.length > 1
  end
end
