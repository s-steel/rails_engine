class Api::V1::MerchantsController < ApplicationController
  def index
    json_response(Merchant.all)
  end

  def show
    json_response(Merchant.find(params[:id]))
  end

  def create
    json_response(Merchant.create!(merchant_params), :created)
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
end
