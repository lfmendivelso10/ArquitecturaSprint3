class NotifierCheckerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'notifiers', :retry => 10, :backtrace => true
  require 'json'

  def perform(record_data)

  end

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Worker Fallido. Enviar a otra zona."
  end

end