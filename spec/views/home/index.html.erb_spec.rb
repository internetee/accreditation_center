require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe "home/index.html.erb", type: :system do
  it 'should be successfully login', :js => true do
    user = User.create!(:username => 'test@example.com', :password => 'f4k3p455w0rd')

    visit root_path

    fill_in :user_username, with: user.username
    fill_in :user_password, with: user.password
    click_on 'Log in'

    expect(page).to have_text "#{user.username}" 
    expect(page.body).to have_text('Signed in successfully.')
  end

  it 'should be login with invalid data', :js => true do
    visit root_path

    fill_in :user_username, with: "test"
    fill_in :user_password, with: "12345"
    click_on 'Log in'

    expect(page.body).to have_text('Invalid Username or password.')
  end

  it 'should logout from system', :js => true do
    user = User.create!(:username => 'test@example.com', :password => 'f4k3p455w0rd')

    visit root_path

    fill_in :user_username, with: user.username
    fill_in :user_password, with: user.password
    click_on 'Log in'

    click_on 'Logout'
    expect(page.body).to have_text('Signed out successfully.')
  end
end
