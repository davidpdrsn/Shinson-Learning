require 'spec_helper'

feature 'viewing neglected studies' do
  scenario 'user sees that he has no neglected studies' do
    sign_in

    expect(page).to have_content "You're doing good on your studies"
  end

  scenario 'user sees that he has some neglected studies' do
    user = create :user
    study = create :study, user: user
    sign_in user

    expect(page).to have_content 'You should consider studying:'
  end
end
