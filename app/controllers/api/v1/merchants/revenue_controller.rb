class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    limit = params[:quantity].to_i
    json_response(MerchantSerializer.new(Merchant.most_revenue(limit)))
  end

  def show
    merchant_id = params[:merchant_id].to_i
    json_response(RevenueSerializer.new(Merchant.revenue(merchant_id)))
  end
end