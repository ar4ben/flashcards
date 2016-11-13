module TestHelpers
  module Features
    def login_user(user, password)
      visit login_url

      fill_in 'user_sessions_email',    with: user.email
      fill_in 'user_sessions_password', with: password

      click_button 'Войти'
    end

    def login_user_post(user, password)
      page.driver.post(user_sessions_url, user_sessions: { email: user.email, password: password })
    end
  end
end
