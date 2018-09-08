Bugsnag.configure do |config|
  config.notify_release_stages = ["production"]
  config.ignore_classes.merge(
    [
      SignalException
    ])
end

ActiveSupport.on_load(:active_record) do
  Bugsnag.configuration.ignore_classes.merge([
    ActiveRecord::RecordNotFound,
  ])
end

ActiveSupport.on_load(:action_controller) do
  Bugsnag.configuration.ignore_classes.merge([
      AbstractController::ActionNotFound,
      ActionController::InvalidAuthenticityToken,
      ActionController::ParameterMissing,
      ActionController::RoutingError,
      ActionController::UnknownFormat,
      ActionController::UnknownHttpMethod,
  ])
end