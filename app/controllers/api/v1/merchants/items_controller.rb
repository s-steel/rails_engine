class Api::V1::Merchants::ItemsController < ApplicationController
  before_action :find_merchant_with_items
  def index
    json_response(@items)
  end

  private

  def find_merchant_with_items
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end
end
