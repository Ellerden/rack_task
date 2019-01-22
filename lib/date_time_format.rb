class MyDateTime
 # attr_reader :formatted_user_request
  FORMATS = { year: '%y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%s' }.freeze
  ACCEPTABLE = FORMATS.keys.map(&:to_s).freeze

  def initialize(params)

    # {"format"=>"year,month,day"}

    # Доступные форматы времени: year, month, day, hour, minute, second

    @formatted_user_request = if params.key?('format')
                                params['format'].split(',')
                              end
  end

  def unknown_format
    @formatted_user_request - ACCEPTABLE
  end

  def valid?
    unknown_format.empty?
  end

  def convert
    time_to_s = @formatted_user_request.map {|f| FORMATS[f.to_sym] }.join('-')
    Time.now.strftime(time_to_s)
  #  @formatted_user_request.select { |f| f.value if FORMAT.key?(f.to_sym) }
  end
end
