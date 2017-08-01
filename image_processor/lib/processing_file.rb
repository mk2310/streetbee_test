module ImageProcessor
  class ProcessingFile
    attr_reader :file_id, :body
    attr_accessor :processed_file

    def initialize(file_id)
      @file_id = file_id
      @body = nil
      @processed_file = nil
    end

    def download
      response = JSON.parse(RestClient.get(file_url).body)
      raise StandardError.new(response['error']) if response['error']
      @body = Base64.decode64(response.fetch('file'))
      self
    end

    def upload
      response_body = RestClient.post(
        CONFIG.file_server_url,
        { id: file_id, file: Base64.encode64(processed_file) }
      ).body
      response = JSON.parse(response_body)['state']
      response == 0
    end

    def file_url
      [CONFIG.file_server_url, @file_id].join
    end
  end
end
