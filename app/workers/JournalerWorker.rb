class JournalerWorker
  include Sidekiq::Worker

  def perform(record)
    record.save

  end
end