module ImageProcessor
  class Config
    attr_reader :processing_exchange,
                :processing_queue,
                :file_server_url

    def self.load
      self.new.load_sneakers
    end

    def initialize
      @processing_exchange = 'image_processing'
      @processing_queue = @processing_exchange.to_sym
      @file_server_url = 'http://172.21.0.1:4330/file_server/api/v1/images/'
    end

    def load_sneakers
      Sneakers.configure  :heartbeat => 20,
                          :amqp => 'amqp://guest:guest@172.21.0.1:5672',
                          :vhost => '/',
                          :durable => true,
                          :ack => true,
                          :threads => 10,
                          :prefetch => 10,
                          :timeout_job_after => 90,
                          :workers => 1,
                          :log_stderr => true,
                          :log  => './sneakers/sneakers.log',
                          :pid_path => './sneakers/sneakers.pid'
      Sneakers.logger.level = Logger::ERROR
      self
    end
  end
end
