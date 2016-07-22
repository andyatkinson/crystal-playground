require "http/client"
require "json"

class Chucky
  def get_joke(id : Int32) : String
    response = HTTP::Client.get "http://api.icndb.com/jokes/#{id}"
    JSON.parse(response.body)["value"]["joke"].to_s rescue ""
  end

  def get_jokes(ids : Array(Int32)) : Array(String)
    ids.map do |id|
      get_joke(id)
    end
  end
end

c = Chucky.new
# puts c.get_joke(20)

puts c.get_jokes([20])
