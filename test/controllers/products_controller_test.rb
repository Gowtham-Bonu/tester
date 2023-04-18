require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.last
    sign_in @user
    @product = products(:one)
  end

  test "go to index" do
    get root_path
    assert_equal "index", @controller.action_name
    assert_response :success
  end

  test "should get new" do
    get new_product_path
    assert_response :success
  end

  test "should create a product" do
    assert_difference("Product.count")do
      post products_path, params: {product: {product_name: "kaisjndm", price: 2, description: nil, user_id: @user.id}}
    end
    assert_redirected_to root_path
    assert_equal "you have successfully created a product", flash[:notice]
  end

  test "should edit product" do
    get edit_product_path(@product)
    assert_equal "edit", @controller.action_name
    assert_response :success
  end

  test "should update product" do
    patch product_path(@product), params: {product: {product_name: "updated", price: 5, description: "lsdfn", user_id: @user.id}}
    assert_equal "you have successfully updated the product", flash[:notice]
    assert_redirected_to root_path
  end

  test "should delete product" do
    assert_difference("Product.count", -1) do
      delete product_path(@product)
    end
    assert_equal "you have successfully deleted the product", flash[:notice]
    assert_redirected_to root_path
  end

  test "trying user to add a product after signinng out" do
    sign_out @user
    get new_product_path
    assert_response :redirect
  end
end
