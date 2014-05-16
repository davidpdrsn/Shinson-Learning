def sign_up user = build(:user)
  visit root_path

  click_link "Sign up"
  fill_in "Email", with: user.email
  fill_in "user_password", with: user.password
  fill_in "user_password_confirmation", with: user.password
  fill_in "First name", with: user.first_name
  fill_in "Last name", with: user.last_name
  click_button "Sign up"
end

def logout
  visit root_path
  click_link "Log out"
end

def sign_in user = create(:user)
  visit root_path

  click_link "Log in"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end
