class RecordController < ApplicationController
  include RecordHelper
  protect_from_forgery :except => :post

  def post
    #Receiver
    record = Record.new(
        collarId: params[:collarId],
        latitude: params[:latitude],
        longitude: params[:longitude],
        breathingFrequency: params[:breathingFrequency],
        hearthFrequency: params[:hearthFrequency],
        systolicPressure: params[:systolicPressure],
        diastolicPressure: params[:diastolicPressure],
        temperature: params[:temperature]
    )

    # Response
    result = process_record(record)
    render json: result
  end

  def get

  end

  def loader
    render :text => ""
  end
end
