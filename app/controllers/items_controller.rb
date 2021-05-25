class ItemsController < ApplicationController
  def index
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :status_id, :shipping_cost_id, :prefecture_id, :days_to_ship_id, :image).merge(user:id: current_user.id)
  end
end