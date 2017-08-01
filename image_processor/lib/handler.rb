module ImageProcessor
  class Handler
    def initialize(file)
      @strio = StringIO.new(file)
      @image = MiniMagick::Image.read(@strio)
    end

    def perform
      @image.flip
      @image.tempfile.open.read
    end
  end
end
