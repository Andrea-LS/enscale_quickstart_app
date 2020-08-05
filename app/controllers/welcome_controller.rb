class WelcomeController < ApplicationController
  def index
    @active_job_setup = ExampleJob.perform_now
    @master_key_env = ENV['RAILS_MASTER_KEY'].present?
    @master_key_file = master_key_file
    @ssl_on = request.ssl?

    # @db = Test.connection.present?
    @db = true

    @all_done = @active_job_setup && @master_key_file && @ssl_on

    respond_to do |format|
      format.html
      format.json {
        render json: {
          active_job_setup: @active_job_setup,
          master_key_env: @master_key_env,
          master_key_file: @master_key_file,
          ssl_on: @ssl_on
        }
      }
    end
  end

  private

  def master_key_file
    path = File.join(Rails.root, "config", "master.key")
    return File.file?(path)
  end
end