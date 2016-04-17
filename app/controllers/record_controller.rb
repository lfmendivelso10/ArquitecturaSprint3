class RecordController < ApplicationController
  include RecordHelper
  protect_from_forgery :except => :post

  def post
    # Statistics record
    journalerTime = StatictisJournaler.new
    processTime = StatictisProcess.new
    d_begin = DateTime.now.strftime('%Q')

    #Unmasharller
    record = Record.new(
        collarId: params[:collarId],
        latitude: params[:latitude],
        longitude: params[:longitude],
        breathingFrequency: params[:breathingFrequency],
        heartFrequency: params[:heartFrequency],
        systolicPressure: params[:systolicPressure],
        diastolicPressure: params[:diastolicPressure],
        temperature: params[:temperature],
        status: 'receiver'
    )

    d_end = DateTime.now.strftime('%Q')
    t_unmarshaller = d_end.to_f - d_begin.to_f
    journalerTime.d_unmarshaller_begin = d_begin.to_s
    journalerTime.d_unmarshaller_end= d_end.to_s
    journalerTime.t_unmarshaller= t_unmarshaller.to_i
    journalerTime.collarId = record.collarId
    processTime.d_unmarshaller_begin = d_begin.to_s
    processTime.d_unmarshaller_end = d_end.to_s
    processTime.t_unmarshaller = t_unmarshaller.to_i
    processTime.collarId = record.collarId

    JournalerWorker.perform_async(record.to_json.to_s,journalerTime.to_json)
    LocationAnalysisWorker.perform_async(record.to_json.to_s,processTime.to_json)

    render json: record
  end

  def get

  end

  def loader
    render :text => ""
  end
end
