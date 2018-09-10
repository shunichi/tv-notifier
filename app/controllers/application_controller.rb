class ApplicationController < ActionController::Base
  def new_session_path(scope)
    new_user_session_path
  end

  def after_omniauth_failure_path_for(scope)
    root_path
  end
end
