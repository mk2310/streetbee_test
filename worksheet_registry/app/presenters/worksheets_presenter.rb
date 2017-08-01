class WorksheetsPresenter
  def self.show_list(count = nil)
    list = Worksheet.where(processed: true)
    if list.nil?
      []
    else
      return list
        .order(created_at: :desc)
        .limit(count ||
          Rails.configuration.worksheet_presenter_list_size).map do |worksheet|
          self.response(worksheet)
      end
    end
  end

  def self.show_record(id)
    worksheet = Worksheet.find(id)
    self.response(worksheet)
  end

  def self.response(worksheet)
    {
      worksheet_id: worksheet.id,
      attachment_urls: worksheet.attachments.map do |attach|
        [Rails.configuration.image_url, attach.id, '?processed=true'].join
      end
    }
  end
end
