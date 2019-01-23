class TimeFormatter
  FORMATS = { year: '%y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%s' }.freeze
  ACCEPTABLE = FORMATS.keys.map(&:to_s).freeze

  # Доступные форматы времени: year, month, day, hour, minute, second
  def initialize(params)
    @formatted_user_request = params.split(',')
  end

  def unknown_format
    @formatted_user_request - ACCEPTABLE
  end

  def valid?
    unknown_format.empty?
  end

  def convert
    time_format = @formatted_user_request.map { |f| FORMATS[f.to_sym] }.join('-')
    Time.now.strftime(time_format)
  end
end
