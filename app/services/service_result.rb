class ServiceResult
  attr_accessor :data, :errors

  def initialize(data: {})
    @data = data
    @errors = []
  end

  def success?
    errors.empty?
  end

  def error?
    errors.any?
  end

  def add_error(code:, message: )
    errors << { code: key, message: message }
  end

  def error_added?(code:)
    errors.any? {|k| k[:code] == key}
  end

  def add_data(hash)
    data.merge!(hash)
  end

  def method_missing(message, *args, &block)
    data[message.to_sym]
  end

  def first_error_message
    errors.first[:message] if error?
  end
end
