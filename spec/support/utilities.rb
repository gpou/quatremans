include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "session_email",    with: user.email
  fill_in "session_password", with: user.password
  click_button I18n.t('sessions.signin')
  cookies[:remember_token] = user.remember_token
end