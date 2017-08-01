module ImageProcessor
  class Server
    def self.start
      sleep 5
      Sneakers.server = true
      Sneakers::Runner.new([Worker]).run
    end
  end
end
