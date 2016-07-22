require "http/client"
require "json"

class Chucky
  def get_joke(id : Int32) : String
    response = HTTP::Client.get "http://api.icndb.com/jokes/#{id}"
    JSON.parse(response.body)["value"]["joke"].to_s rescue ""
  end

  def get_jokes(ids : Array(Int32)) : Array(String)

    # 1. create a channel in the main fiber, type of the channel is specified
    chan = Channel(String).new

    # 2. Execute get_joke() in a fiber, send the result to a channel
    ids.map do |x|

      spawn do
        chan.send(get_joke(x))
      end

    end

    # 3. receive the results
    (1..ids.size).map do |x|
      chan.receive
    end
  end
end

c = Chucky.new
# puts c.get_joke(20)

puts c.get_jokes([20])
