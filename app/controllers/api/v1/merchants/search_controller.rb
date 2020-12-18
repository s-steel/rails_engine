class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = params.keys[0]
    value = params.values[0]
    json_response(MerchantSerializer.new(Merchant.search_one(attribute, value)))
  end

  def index
    attribute = params.keys[0]
    value = params.values[0]
    json_response(MerchantSerializer.new(Merchant.search_all(attribute, value)))
  end
end
