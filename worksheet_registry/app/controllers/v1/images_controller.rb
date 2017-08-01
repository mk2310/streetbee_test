class V1::ImagesController < ApplicationController
  def show
    set_attachment
    render json: {
      file: Base64.encode64(
        FileManageService.new.get_file(
          params[:processed] ? @attach.processed_filename : @attach.filename,
          @attach.created_at.strftime('%Y-%m-%d')
        ).read
      )
    }
  rescue
    render json: { error: 'something went wrong' }
  end

  def create
    set_attachment
    processed_filename = FileManageService.new.write_file(
      Base64.decode64(params[:file]),
      ['processed', @attach.original_filename].join('_')
    )
    @attach.update(processed_filename: processed_filename)
    @attach.processed!
    @attach.worksheet.processed?
    render json: { state: 0 }
  rescue
    render json: { state: 1 }
  end

  private

  def set_attachment
    @attach = Attachment.find(params[:id])
  end
end
