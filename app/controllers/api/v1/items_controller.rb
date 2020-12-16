class Api::V1::ItemsController < ApplicationController
  before_action :find_merchant, only: [:index]
  def index
    if find_merchant.nil?
      json_response(ItemSerializer.new(Item.all))
    else
      json_response(ItemSerializer.new(@merchant.items))
    end
  end

  def show
    json_response(ItemSerializer.new(Item.find(params[:id])))
  end

  def create
    item = Item.create!(item_params)
    json_response(ItemSerializer.new(item), :created)
  end

  def update
    json_response(ItemSerializer.new(Item.update(params[:id], item_params)))
    # head :no_content
  end

  def destroy
    json_response(Item.delete(params[:id]))
    head :no_content
  end

  def find
    attribute = params.keys[0]
    value = params.values[0]
    json_response(ItemSerializer.new(Item.search_one(attribute, value)))
  end

  def find_all
    attribute = params.keys[0]
    value = params.values[0]
    json_response(ItemSerializer.new(Item.search_all(attribute, value)))
  end

  private

  def item_params
    params.permit(:name,
                  :description,
                  :unit_price,
                  :merchant_id)
  end

  def find_merchant
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
    else
      nil
    end
  end
end
