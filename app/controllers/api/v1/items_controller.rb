class Api::V1::ItemsController < ApplicationController
  def index
    json_response(Item.all)
  end

  def show
    json_response(Item.find(params[:id]))
  end

  def create
    item = Item.create!(item_params)
    json_response(item, :created)
  end

  def update
    json_response(Item.update(params[:id], item_params))
    head :no_content
  end

  def destroy
    json_response(Item.delete(params[:id]))
    head :no_content
  end

  private

  def item_params
    params.permit(:name,
                  :description,
                  :unit_price,
                  :merchant_id)
  end
end