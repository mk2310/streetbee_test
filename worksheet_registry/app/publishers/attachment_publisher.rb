class AttachmentPublisher
  def self.publish(attachment_id)
    Sneakers::Publisher
      .new(exchange: 'image_processing')
      .publish(
        JSON.dump(id: attachment_id),
        routing_key: 'image_processing'
      )
  end
end
