class RevenueSerializer
  def self.revenue(object)
    if object.class == Float
      {
        "data": {
          "id": nil,
          "attributes": {
            "revenue": object
          }
        }
      }
    else
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
end
