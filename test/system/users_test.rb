require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    login_as @user
  end

  test 'visiting the index' do
    visit users_url
    assert_selector 'h1', text: 'Users'
  end

  test 'should create user' do
    visit users_url
    click_on 'New user'

    fill_in 'Name', with: 'new user'
    fill_in 'Password', with: 'secret'
    fill_in 'Confirm', with: 'secret'
    click_on 'Create User'

    assert_text 'User new user was successfully created'
  end

  test 'should update User' do
    visit user_url(@user)
    click_on 'Edit this user', match: :first

    fill_in 'Name', with: @user.name
    fill_in 'Old Password', with: 'secret'
    fill_in 'New Password', with: 'newsecret'
    fill_in 'Confirm New Password', with: 'newsecret'
    click_on 'Update User'

    assert_text "User #{@user.name} was successfully updated"
  end

  test 'should destroy User' do
    visit user_url(@user)
    accept_confirm { click_on 'Destroy this user', match: :first }
  end
end
