class DifferentiationService

  def initialize(coefficients)
    @coefficients = coefficients
    @result = ServiceResult.new
  end

  def call
    differentiate_to_expression @coefficients
    @result
  end

  private

  def differentiate_to_expression(coefficients)
    all_integers = coefficients.each { |i| Integer(i) } rescue nil
    if all_integers
      integers = coefficients.map(&:to_i)
      largest_power = integers.length - 1
      ascending = integers.reverse
      multiplied = ascending.each_with_index.map { |coefficient, exponent| coefficient * exponent }
      new_terms = multiplied.reverse.each_with_index.map do |coefficient, idx|
        current_exponent = largest_power - 1 - idx
        show_power = current_exponent > 1 ? "^#{largest_power - 1 - idx}" : ""
        show_x = current_exponent > 0 ? "x" : ""
        "#{coefficient > 0 ? '+' : ''}#{coefficient}#{show_x}#{show_power}" if coefficient != 0
      end
      expression = new_terms.join('').gsub(/^\+/,'') # remove leading plus sign
      @result.add_data(expression: expression)
    else
      @result.add_error(code: :bad_request, message: 'one or more coefficients are not integers')
    end
  end
end
