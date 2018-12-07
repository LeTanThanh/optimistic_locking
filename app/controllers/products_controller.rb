class ProductsController < ApplicationController
  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "Product was successfully created."
      redirect_to @product
    else
      flash.now[:danger] = "Product wasn't successfully created."
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update_attributes(product_params)
      flash[:success] = "Product was successfully updated."
      redirect_to @product
    else
      flash.now[:danger] = "Product wasn't successfully updated."
      render :edit
    end
  rescue ActiveRecord::StaleObjectError
    flash.now[:danger] = "Product wasn't successfully updated."
    @product.reload
    render :edit_conflict
  end

  def destroy
    if @product.destroy
      flash[:success] = "Product was successfully destroyed."
    else
      flash[:success] = "Product wasn't successfully destroyed."
    end

    redirect_to products_url
  end

  private
  def load_product
    @product = Product.find_by(id: params[:id])

    unless @product
      flash[:danger] = "Product wasn't found."
      redirect_to products_url
    end
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :lock_version)
  end
end
