class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to root_path, notice: "you have successfully created a product"
    else
      flash.now[:alert] = "Invalid request"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to root_path, notice: "you have successfully updated the product"
    else
      flash.now[:alert] = "Invalid request"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "you have successfully deleted the product"
    else
      flash[:alert] = "Invalid request"
    end
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :price, :description, :user_id)
  end
end
