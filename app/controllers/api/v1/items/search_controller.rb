class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = params.keys[0]
    value = params.values[0]
    json_response(ItemSerializer.new(Item.search_one(attribute, value)))
  end

  def index
    attribute = params.keys[0]
    value = params.values[0]
    json_response(ItemSerializer.new(Item.search_all(attribute, value)))
  end
end