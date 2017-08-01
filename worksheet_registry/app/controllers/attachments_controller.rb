class AttachmentsController < ApplicationController
  def create
    AttachmentProcessingService
      .new
      .perform(
        params[:files].values
      )
  end
end
