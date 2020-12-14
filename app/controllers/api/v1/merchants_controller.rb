class Api::V1::MerchantsController < ApplicationController
  before_action :find_item, only: [:index]
  def index
    if find_item.nil?
      json_response(Merchant.all)
    else
      json_response(@item.merchant)
    end
  end

  def show
    json_response(Merchant.find(params[:id]))
  end

  def create
    merchant = Merchant.create!(merchant_params)
    json_response(merchant, :created)
  end

  def update
    json_response(Merchant.update(params[:id], merchant_params))
    head :no_content
  end

  def destroy
    json_response(Merchant.delete(params[:id]))
    head :no_content
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def find_item
    if params[:item_id]
      @item = Item.find(params[:item_id])
    else
      nil
    end
  end
end
