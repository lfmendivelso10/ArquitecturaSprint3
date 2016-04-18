class NotifierCheckerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'notifiers', :retry => 10, :backtrace => true

  sidekiq_retries_exhausted do |msg|
    processT = JSON.parse(msg['args'][0].to_s)
    RestClient.post "http://localhost:3000/recover/notify", processT.to_json, :content_type => :json, :accept => :json
    errorData = ErrorLog.new(worker: 'ErrorWorker',data: msg['args'].to_s)
    errorData.save!
  end

  def perform(data)
    d_begin = DateTime.now.strftime('%Q')
    processT = JSON.parse(data.to_s)
    processTime = StatictisProcess.new.from_json(processT.to_json)

    # Send a notification to the PetOwner
    pet = Collar.find_by_collarId(processTime.collarId.to_s).pet
    petConditions = PetCondition.find_by_pet_id(pet.id)
    puts 'Mensaje enviado a '+petConditions.ownerEmail.to_s+'. Estado: '+pet.petStatus.to_s
    d_end = DateTime.now.strftime('%Q')
    t_output = d_end.to_f - d_begin.to_f
    processTime.d_output_begin=d_begin.to_s
    processTime.d_output_end=d_end.to_s
    processTime.t_output = t_output+1
    processTime.t_process = processTime.t_process.to_i + t_output.to_i
    processTime.t_insqs_queue = (d_begin.to_f - processTime.d_businesslogic_end.to_f).to_i
    processTime.t_perception = processTime.t_process + processTime.t_insqs_queue
    processTime.save!
  end

end