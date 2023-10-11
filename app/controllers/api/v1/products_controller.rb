class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products ,status: 200
  end

  def show
    product =Product.find_by(id:params[:id])
    if product
      render json: product ,status:200
    else
      render json: {error: "Product not found"}
    end
  end

  def create
    product =Product.new(prod_params)
    if product.save    
      render json: product ,status:200
    else
      render json: {error: "Product not created"}
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(prod_params)
      render json: product ,status:200
    else
      render json: {error: "could not able to update"}
    end
  end

  def destroy
    product =  Product.find(params[:id])
    if product.destroy
      render json: { message: "Product has been deleted" }, status: 200
    else
      render json: {error: "could not able to delete"},status: 400
    end

  end

  def prod_params
    params.require(:product).permit(:name ,:brand ,:price)
  end
end
