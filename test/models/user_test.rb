require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(email: "sdasda@mail.com", password: "r5thygrthyrhyt")
  end

  test "email must exist" do
    assert_not_nil(@user.email, "email must be present")
  end

  test "password must exist" do
    assert_not_nil(@user.password, "password must be present")
  end

  test "email is not empty" do
    assert_not_empty(@user.email, "email shouldn't be empty")
  end

  test "password is not empty" do
    assert_not_empty(@user.password, "password shouldn't be empty")
  end

  test "password is minimum 6 in length" do
    assert_includes((6..128), @user.password.length, "password length should minimum be 6")
  end

  test "check if user is valid" do
    assert @user.valid?, "not a valid user"
  end

  test "user must have 2 products" do
    @user.products = [products(:one), products(:two)]
    assert_equal(2, @user.products.size, "should have more than one products")
  end
end
