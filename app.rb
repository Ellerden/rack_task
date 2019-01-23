require_relative 'lib/time_formatter'

class App
  def call(env)
    request = Rack::Request.new(env)

    if request.get? && request.path == '/time' && request.params['format']
      formatted_time_response(request.params)
    else
      send_response(404, 'Something went wrong. Page Not Found')
    end
  end

  private

  def formatted_time_response(params)
    user_format = TimeFormatter.new(params['format'])
    if user_format.valid?
      send_response(200, user_format.convert)
    else
      send_response(400, "Unknown time format [#{user_format.unknown_format.join(', ')}]")
    end
  end

  def send_response(status, body)
    [status, headers, [body + "\n"]]
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end
end
