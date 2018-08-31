Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, ENV["LINE_CHANNEL_ID"], ENV["LINE_CHANNEL_SECRET"]
  provider :line_notify,  ENV["LINE_NOTIFY_CLIENT_ID"], ENV["LINE_NOTIFY_CLIENT_SECRET"], scope: 'notify'
end
