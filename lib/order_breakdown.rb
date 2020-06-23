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

    # breakdown_for_packages(bakery_packages, quantity)
    breakdown_for_packages_non_recursive(bakery_packages, quantity)

    raise StandardError, 'No suitable packages' unless @order.total_quantity.positive?

    @order
  end

  private

  def breakdown_for_packages_non_recursive(bakery_packages, quantity)
    quantity_left = quantity
    package_level = 0
    result = []

    loop do
      package = bakery_packages[package_level]
      package_count = quantity_left / package[:quantity]
      quantity_left = quantity_left % package[:quantity]

      result << {
        package: package,
        count: package_count,
        quantity: package[:quantity],
        quantity_left: quantity_left
      }

      # successfuly find solution
      break if quantity_left == 0

      # didn't find solution, try another breakdown
      if package_level == bakery_packages.count - 1
        result.pop
        result.pop until result.last[:count] > 0

        break if result.count == 0

        result.last[:count] -= 1
        quantity_left = result.last[:quantity_left] + result.last[:quantity]
      end

      package_level = result.count
    end

    bakery_packages.reverse.each_with_index do |package, index|
      count = result[index].nil? ? 0 : result[index][:count]
      @order.add_package_result({
        count: count,
        package: package
      })
    end
  end

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
