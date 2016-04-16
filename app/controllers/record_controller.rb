class RecordController < ApplicationController
  include RecordHelper
  protect_from_forgery :except => :post

  def post
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

    # redis = Redis.new
    # receiver = redis.get('receiver_f').to_s
    # if receiver != nil
    #   receiver = "0"
    # end
    # receiver_f = receiver.to_i+1;
    # record_flat = 'r'+receiver_f.to_s
    # redis.set(record_flat,record.to_json)
    # puts record_flat
    # redis['receiver_f'] = receiver_f.to_s
    # redis.quit


    JournalerWorker.perform_async(record.to_json.to_s)
    LocationAnalysisWorker.perform_async(record.to_json.to_s)

    render json: record
  end

  def get

  end

  def loader
    render :text => ""
  end
end
