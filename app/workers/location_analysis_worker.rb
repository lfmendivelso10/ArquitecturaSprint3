class LocationAnalysisWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'businesslogic', :retry => 10, :backtrace => true
  require 'json'

  sidekiq_retries_exhausted do |msg|
    recordJson = JSON.parse(msg['args'][0].to_s)
    RestClient.post "http://localhost:3000/recover/record", recordJson.to_json, :content_type => :json, :accept => :json
    errorData = ErrorLog.new(worker: 'ErrorWorker',data: msg['args'][0].to_s)
    errorData.save!
  end

  def perform(record_data,process_time)
    processT = JSON.parse(process_time.to_s)
    processTime = StatictisProcess.new.from_json(processT.to_json)
    d_begin = DateTime.now.strftime('%Q')

    recordJson = JSON.parse(record_data.to_s)
    record = Record.new.from_json(recordJson.to_json)
    pet = Collar.find_by_collarId(record.collarId).pet
    conditions = PetCondition.find_by_pet_id(pet.id)
    is_safe = 0
    zones = SafeZone.where(pet_id: pet.id)
    zones.each do |zone|
      is_safe = (((record.latitude - zone.latitude)**2)*1000000) + (((record.latitude - zone.latitude)**2)*1000000) < (zone.radius/100) ? 0 : 1
      break is_safe > 0
    end
    if is_safe > 0
      pet.petStatus= 'In Danger'
      pet.save!
      processTime.notify=1
    else
      pet.petStatus= 'OK'
      pet.save!
      processTime.notify=0
    end
    conditions.update_columns(latitude: record.latitude,
                              longitude: record.longitude,
                              breathingFrequency: record.breathingFrequency,
                              heartFrequency: record.heartFrequency,
                              systolicPressure: record.systolicPressure,
                              diastolicPressure: record.diastolicPressure,
                              temperature: record.temperature)
    puts 'status: '+pet.petStatus.to_s
    d_end = DateTime.now.strftime('%Q')
    t_businesslogic = d_end.to_f - d_begin.to_f
    processTime.d_businesslogic_begin = d_begin.to_s
    processTime.d_businesslogic_end= d_end.to_s
    processTime.t_businesslogic = t_businesslogic.to_i
    processTime.t_process = processTime.t_unmarshaller.to_i + t_businesslogic.to_i
    processTime.t_inredis_queue = d_end.to_i - processTime.d_unmarshaller_end.to_i
    if processTime.notify ==0
      processTime.t_perception = processTime.t_process + processTime.t_inredis_queue
      processTime.save!
    else
      sqs = sqs = Aws::SQS::Client.new(
          region: ENV['AWS_ADMIN_REGION'],
          credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']  ),
      )
      msg = sqs.send_message(
          queue_url: ENV['AWS_SQS_URL'].to_s,
          message_body: processTime.to_json.to_s
      )
      logger.info('Mensaje Enviado : '+msg.message_id.to_s)
    end

    
  end

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Worker Fallido. Enviar a otra zona."
  end

end