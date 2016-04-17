# NotifierChecker.rb
# Description:  This component is designed to verify the notifications queue every 1 second.
#               In which it's going to use a 10 threads to review 100 notifications per second.
# @autor: Luis Felipe Mendivelso Osorio - lf.mendivelso10@uniandes.edu.co
# @since: 17-04-2016
# @version: 0.0.3

#Dependecies
require 'rufus-scheduler'

# Verify the type of instance
if ENV['TYPE_INSTANCE'] == 'AlertWorker'

  # # Define a variable to control the number of thread to use for notify.
  # inspector = 10
  # # Create a component to schedule the execution every specific time.
  # scheduler = Rufus::Scheduler.new
  # # Launche the schedule component every 1s
  # scheduler.every '1s' do
  #   (0..inspector).each do |i|
  #     NotifierCheckerWorker.perform_async('inspector '+i.to_s)
  #   end
  # end

  Thread.new do

    # Default configuration
    queue_url = ENV['AWS_SQS_URL'].to_s

    # Definition of the SQS Poller which polls every 20 seconds a long list of message store in
    # the SQS queue and work indefinitely. This is useful to process
    poller = Aws::SQS::QueuePoller.new(queue_url)

    # Poll a long list of SQS message
    poller.poll do |msg|
      begin
        puts msg.body.to_s
        NotifierCheckerWorker.perform_async(msg.body.to_s)
      rescue
        # In case of fail, skip the message's delete, to recover forward.
        throw :skip_delete
      end
    end
  end
end