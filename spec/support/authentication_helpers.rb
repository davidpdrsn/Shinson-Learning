def sign_up(email = 'bob@example.com', password = 'passwordlol')
  visit root_path

  fill_in "Email", with: email
  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password
  click_button "Sign up"
end

def logout
  visit root_path
  click_link "Log out"
end

def sign_in(email = 'bob@example.com', password = 'passwordlol')
  visit root_path

  click_link "Sign in"
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
end
