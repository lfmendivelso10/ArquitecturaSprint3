module RecordHelper

  def process_record(record)
    components = []
    pet = Pet.new
    # Journaler
    components << Thread.new do
      transaction = TransactionLog.new(component: 'journaler', data: record.as_json.to_s, status: 'in process')
      transaction.save!
    end
    # Un-marshaller
    components << Thread.new do
      pet = Collar.find_by_collarId(record.collarId).pet
      petCondition = PetCondition.find_by_pet_id(pet.id)
      petCondition.latitude = record.latitude
      petCondition.longitude = record.longitude
      petCondition.breathingFrequency = record.breathingFrequency
      petCondition.heartFrequency = record.hearthFrequency
      petCondition.systolicPressure = record.systolicPressure
      petCondition.diastolicPressure = record.diastolicPressure
      petCondition.temperature = record.temperature
      petCondition.save!
    end
    # Replicator
    components << Thread.new do
      record.save!
    end
    # Sincronizar hilos
    components.each do |t|
      t.join
    end

    # Business Logic Consumer
    is_safe = 0
    zones = SafeZone.where(pet_id: pet.id)
    zones.each do |zone|
      is_safe = is_safe + (((record.longitude - zone.longitude)**2 + (record.latitude - zone.latitude)**2) > (zone.radius**2) ? 1 : 0)
      break is_safe > 0
    end

    if is_safe > 0
      return 'Alert'
    else
      return 'OK'
    end
  end
end
