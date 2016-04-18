class RecoverController < ApplicationController
  skip_before_action :verify_authenticity_token

  def record
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

  def notify
    # Statistics record
    d_begin = DateTime.now.strftime('%Q')

    #Unmasharller
    processTime = StatictisProcess.new(
        collarId: params[:collarId],
        d_unmarshaller_begin: d_begin.to_s
    )

    sqs = Aws::SQS::Client.new
    d_end = DateTime.now.strftime('%Q')
    t = d_end.to_f - d_begin.to_f
    processTime.d_unmarshaller_end = d_end.to_s
    processTime.t_unmarshaller = t.to_i
    processTime.d_businesslogic_begin = d_begin.to_s
    processTime.d_businesslogic_end= d_end.to_s
    processTime.t_businesslogic = t.to_i
    processTime.t_process = processTime.t_unmarshaller.to_i + t.to_i
    processTime.t_inredis_queue = d_end.to_i - processTime.d_unmarshaller_end.to_i

    msg = sqs.send_message(
        queue_url: ENV['AWS_SQS_URL'].to_s,
        message_body: processTime.to_json.to_s
    )

    render text: 'Mensaje enviado. ID: '+msg.message_id.to_s

  end
end
