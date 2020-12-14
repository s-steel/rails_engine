class Api::V1::ItemsController < ApplicationController
  def index
    json_response(Item.all)
  end
end