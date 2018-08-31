class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_by_auth_hash!(auth_hash)
    if user
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Line'
      sign_in_and_redirect user, event: :authentication
    else
      redirect_to root_url, alert: 'ログインに失敗しました'
    end
  end

  def line_notify
    auth = request.env['omniauth.auth']
    params = request.env['omniauth.params']
    token = auth['credentials']['token']

    current_user.line_notification_targets.create!(token: token, auth_hash: auth)
    redirect_to root_url, notice: notice
  end
end
