class RevenueSerializer
  def self.revenue(object)
    if object.instance_of?(Float)
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
