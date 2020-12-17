class Api::V1::Invoices::RevenueController < ApplicationController
  def revenue_by_dates
    start_date = params[:start]
    end_date = params[:end]
    json_response(RevenueSerializer.revenue(Invoice.revenue_by_dates(start_date, end_date)))
  end
end
