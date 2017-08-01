class AttachmentProcessingService
  def perform(attachments)
    file_manager = FileManageService.new
    attachments.each do |attach|
      ActiveRecord::Base.transaction do
        file_name = file_manager
          .write_file(
            attach.tempfile.read,
            attach.original_filename
          )
        publish(create_attachment(attach.original_filename, file_name, create_worksheet.id))
      end
    end
  end

  def create_worksheet
    Worksheet.create!
  end

  def create_attachment(original_filename, file_name, worksheet_id)
    Attachment.create!(
      original_filename: original_filename,
      filename: file_name,
      worksheet_id: worksheet_id
    )
  end

  def publish(attachment)
    AttachmentPublisher.publish(attachment.id)
    attachment.sent_for_processing!
  end
end
