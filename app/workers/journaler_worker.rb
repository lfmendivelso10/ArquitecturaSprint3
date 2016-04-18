
class JournalerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'journaler', :retry => 10, :backtrace => true
  require 'json'

  sidekiq_retries_exhausted do |msg|


    recordJson = JSON.parse(msg['args'][0].to_s)
    RestClient.post "http://localhost:3000/recover/record", recordJson.to_json, :content_type => :json, :accept => :json
    errorData = ErrorLog.new(worker: 'ErrorWorker',data: msg['args'][0].to_s)
    errorData.save!
  end

  def perform(record_data,journaler_time)
    journalerTime = JSON.parse(journaler_time.to_s)
    jTime = StatictisJournaler.new.from_json(journalerTime.to_json)
    d_begin = DateTime.now.strftime('%Q')

    recordJson = JSON.parse(record_data.to_s)
    record = Record.new.from_json(recordJson.to_json)
    record.save!

    d_end = DateTime.now.strftime('%Q')
    t_journaler = d_end.to_f - d_begin.to_f
    jTime.d_journaler_begin = d_begin.to_s
    jTime.d_journaler_end= d_end.to_s
    jTime.t_journaler = t_journaler.to_i
    jTime.t_process = jTime.t_unmarshaller.to_i + t_journaler.to_i
    jTime.t_inredis_queue = d_end.to_i - jTime.d_unmarshaller_end.to_i
    jTime.t_perception = jTime.t_process + jTime.t_inredis_queue
    jTime.save!
  end

end