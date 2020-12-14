class Api::V1::ItemsController < ApplicationController
  def index
    json_response(Item.all)
  end

  def show
    json_response(Item.find(params[:id]))
  end
end