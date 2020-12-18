class RevenueSerializer
  def self.revenue(object)
    {
      "data": {
        "id": nil,
        "attributes": {
          "revenue": object.revenue
        }
      }
    }
  end
end
