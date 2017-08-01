class WorksheetsController < ApplicationController
  before_action :login_before_action

  WORKSHEETS_COUNT = 10

  def index
    render json: {
      list: WorksheetsPresenter.show_list(WORKSHEETS_COUNT),
      worksheet_url: worksheets_url
    }
  end

  def show
    render json: {
      record: WorksheetsPresenter.show_record(params[:id]),
      worksheet_url: worksheet_url(params[:id])
    }
  end

  def update
    Worksheet
      .find(params[:id])
      .update(decision: params[:decision])
  end
end
