class LocationAnalysisWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'businesslogic', :retry => 10, :backtrace => true
  require 'json'

  def perform(record_data)
    recordJson = JSON.parse(record_data.to_s)
    record = Record.new.from_json(recordJson.to_json)
    pet = Collar.find_by_collarId(record.collarId).pet
    conditions = PetCondition.find_by_pet_id(pet.id)
    is_safe = 0
    zones = SafeZone.where(pet_id: pet.id)
    zones.each do |zone|
      is_safe = is_safe + (((record.longitude - zone.longitude)**2 + (record.latitude - zone.latitude)**2) > (zone.radius**2) ? 1 : 0)
      break is_safe > 0
    end
    if is_safe > 0
      pet.petStatus= 'OK'
      pet.save!
    else
      pet.petStatus= 'In Danger'
      pet.save!
    end
    conditions.update_columns(latitude: record.latitude,
                              longitude: record.longitude,
                              breathingFrequency: record.breathingFrequency,
                              heartFrequency: record.heartFrequency,
                              systolicPressure: record.systolicPressure,
                              diastolicPressure: record.diastolicPressure,
                              temperature: record.temperature)
  end

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Worker Fallido. Enviar a otra zona."
  end

end