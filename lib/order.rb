class Order
  attr_reader :result

  def initialize
    @result = []
  end

  def add_package_result(result_package)
    @result << result_package
  end

  def pop_package_result
    @result.pop
  end

  def total_quantity
    @result.inject(0) { |sum, result| sum + result[:count] * result[:package][:quantity] }
  end

  def to_s
    total_price = non_empty_result.inject(0) do |sum, result|
      sum + result[:count] * result[:package][:price]
    end
    details = @result.map do |result|
      "#{result[:count]} x #{result[:package][:quantity]} $#{result[:package][:price]}"
    end
    '$' + total_price.round(2).to_s + "\n" + details.join("\n")
  end

  private

  def non_empty_result
    @result.keep_if { |r| r[:count].positive? }
  end
end
