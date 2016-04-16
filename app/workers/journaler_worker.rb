
class JournalerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'journaler', :retry => 10, :backtrace => true
  require 'json'

  def perform(record_data)
    recordJson = JSON.parse(record_data.to_s)
    record = Record.new.from_json(recordJson.to_json)
    record.save!
  end

end