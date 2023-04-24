require 'rails_helper'

RSpec.describe "Products", type: :request do
  before(:each) do
    @user = create(:user) 
    sign_in @user
    @product = Product.create(valid_attributes)
  end

  let(:valid_attributes) { { product_name: "prodone", price: 21, description: "wiefhfuh wewefuhwifh", user_id: @user.id } }

  let(:invalid_attributes) { { product_name: "", price: "sdf", description: "wiefhfuh wewefuhwifh", user_id: nil} }

  describe "index" do
    it "get to index action and render a successful response" do
      get products_url
      expect(response).to be_successful
    end
  end

  describe "new" do
    it "get to new and render a successful response" do
      get new_product_url
      expect(response).to be_successful
    end
  end

  describe "create" do
    context "with valid parameters" do
      it "create a product" do
        expect {
          post products_path, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it "redirects to root path" do
        post products_path, params: { product: valid_attributes }
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid parameters" do
      it "does not create a new product" do
        expect {
          post products_path, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
      end
  
      it "render new: :status_unprocessable_entity" do
        post products_path, params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "edit" do
    it "gets to edit and renders a successful response" do
      get edit_product_url(@product)
      expect(response).to be_successful
    end
  end

  describe "update" do
    let(:new_attributes) { { product_name: "changed", price: 200, description: "weffeefefwef", user_id: @user.id} }

    it "updates the product" do
      patch product_path(@product), params: { product: new_attributes }
      @product.reload
      expect(response).to redirect_to root_path
    end
  end

  describe "destroy" do
    it "destroy the product" do
      expect{
        delete product_url(@product)
      }.to change(Product, :count).by(-1)
    end

    it "redirect to root path" do
      delete product_url(@product)
      expect(response).to redirect_to root_path
    end
  end
end
