require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @user = User.create(email: "ronu@mail.com", password: "ronu12")
    @product = products(:one)
    @product.update(user_id: @user.id)
  end

  test "product name should exist" do
    assert_not_nil(@product.product_name, "product name should not be null")
  end

  test "product name should not be empty" do
    assert_not_empty(@product.product_name, "product name should not be empty")
  end

  test "product price should exist" do
    assert_not_nil(@product.price, "product price should not be null")
  end

  test "user must exist" do
    assert_not_nil(@product.user_id, "user must exist")
    found_user = User.find_by(id: @product.user_id)
    assert_not_nil(found_user, "user not found")
  end

  test "price must be a number" do
    assert_kind_of(Integer, @product.price, "price must be a number") 
  end

  test "create valid product" do
    assert @product.save, "product is not valid"
  end
end
