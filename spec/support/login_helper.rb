require 'rails_helper'

module LoginHelper
  def login(user)
    visit sessions_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
