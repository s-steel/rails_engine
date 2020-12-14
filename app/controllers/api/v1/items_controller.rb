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

  private

  def item_params
    params.permit(:name,
                                 :description,
                                 :unit_price,
                                 :merchant_id)
  end
end