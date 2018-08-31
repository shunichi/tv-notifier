require 'net/http'
require 'uri'

module Line
  class Notify
    SEND_URI   = URI.parse("https://notify-api.line.me/api/notify")
    REVOKE_URI = URI.parse("https://notify-api.line.me/api/revoke")

    def initialize(token)
      @token = token
    end

    def send(message)
      request = Net::HTTP::Post.new(SEND_URI)
      request["Authorization"] = "Bearer #{@token}"
      request.set_form_data(message: message)
      Net::HTTP.start(SEND_URI.hostname, SEND_URI.port, use_ssl: true) do |https|
        https.request(request)
      end
    end

    def revoke
      request = Net::HTTP::Post.new(REVOKE_URI)
      request["Authorization"] = "Bearer #{@token}"
      Net::HTTP.start(REVOKE_URI.hostname, REVOKE_URI.port, use_ssl: true) do |https|
        https.request(request)
      end
    end
  end
end
