class OrderParser
  attr_reader :code, :quantity

  def initialize
    @code = nil
    @quantity = nil
  end

  def parse(input)
    @code, @quantity = input.split(' ')
    @quantity = Integer(@quantity)
  rescue StandardError
    raise StandardError, "Invalid input: #{input}"
  end
end
