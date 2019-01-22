require_relative 'lib/date_time_format'

class App
  attr_accessor :request, :dd
  def call(env)
    request = Rack::Request.new(env)

    if request.get? && request.path == '/time'
      check_time(request.params)
    else
      send_response(404, 'Something went wrong. Page Not Found')
    end
  end
end

private

def check_time(params)
  user_format = MyDateTime.new(params)
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
