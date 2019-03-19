require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:priyank)
  end
  test "unsucessfull edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
      email: "tushar@gmail.com",
      password:              "foo",
      password_confirmation: "bar" } }
    assert_template 'users/edit'
    end

    test "sucessfull edit with friendly forwarding" do
      get edit_user_path(@user)
      log_in_as(@user)
      assert_redirected_to edit_user_url(@user)
      name  = "Foo Bar"
      email = "foo@bar.com"
      patch user_path(@user), params: { user: { name:  name,
                                                email: email,
                                                password:              "",
                                                password_confirmation: "" } }
      assert_not flash.empty?
      assert_redirected_to @user
      @user.reload
      assert_equal name,  @user.name
      assert_equal email, @user.email
    end
  end

