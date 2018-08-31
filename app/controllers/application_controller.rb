class ApplicationController < ActionController::Base
  def after_omniauth_failure_path_for(scope)
    root_path
  end
end
