class ExampleJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    return true
  end
end
