module ImageProcessor
  class Worker
    include Sneakers::Worker
    from_queue CONFIG.processing_queue,
               exchange: CONFIG.processing_exchange

    def work(msg)
      parsed_msg = JSON.parse(msg)
      file = ProcessingFile.new(parsed_msg['id']).download
      file.processed_file = Handler.new(file.body).perform
      if file.upload
        ack!
      else
        requeue!
      end
    end
  end
end
