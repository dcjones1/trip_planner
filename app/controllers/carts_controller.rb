class CartsController < ApplicationController
  before_action :set_cart, only: [:edit, :show]

  def update
    @cart.update(cart_params)
    if @cart.save
      redirect_to @cart
    else
      render :edit
    end
  end

  def destroy
    @cart.destroy
    redirect_to carts_path
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
