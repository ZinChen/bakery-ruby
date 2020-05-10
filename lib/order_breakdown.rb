class OrderBreakdown
  attr_reader :backery, :order, :target_quantity

  def initialize(backery)
    @backery = backery
    @order = nil
    @target_quantity = nil
  end

  def breakdown(code, quantity)
    @order = Order.new
    @target_quantity = quantity

    backery_packages = backery.packages_by_code(code).sort_by { |p| -p[:quantity] }

    if (backery_packages.length > 0) then
      breakdown_for_packages(backery_packages, quantity)
    end

    @order.total_quantity > 0 ? @order : nil
    # @order.result.map{ |r| r[:count] }
  end

  private

  def breakdown_for_packages(backery_packages, quantity)
    package = backery_packages.first
    package_count = quantity / package[:quantity]

    while package_count >= 0 do
      if (backery_packages.length > 0) then
        process_package(backery_packages, quantity, package_count)
      end

      break if @order.total_quantity == @target_quantity
      @order.pop_package_result
      package_count -= 1
    end
  end

  def process_package(backery_packages, quantity, package_count)
    package = backery_packages.first
    quantity_left = quantity - package[:quantity] * package_count

    @order.add_package_result({
      package: package,
      count: package_count
    })

    if (backery_packages.length > 1) then
      breakdown_for_packages(backery_packages.drop(1), quantity_left)
    end
  end
end
