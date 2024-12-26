class HealthController < ApplicationController
  MAX_DB_CHECK_SECONDS = ENV.fetch("MAX_DB_CHECK_SECONDS", 2).to_f

  def liveness
    Rails.logger.info({ status: "alive" }.to_json)
    render json: { status: "ok", timestamp: Time.current }, status: :ok
  end

  def readiness
    if check_db_health
      Rails.logger.info({ status: :healthy }.to_json)
      render json: {}, status: :ok
    else
      render json: {}, status: :service_unavailable
    end
  end

  private

  def check_service_health(service_name, timeout_duration)
    Async do
      begin
        Async::Task.current.with_timeout(timeout_duration) do
          yield
          true
        end
      rescue Async::TimeoutError
        Rails.logger.warn({ status: :unhealthy, error: "#{service_name} check timed out" }.to_json)
        false
      rescue => e
        Rails.logger.warn({ status: :unhealthy, error: e.message }.to_json)
        false
      end
    end.wait
  end

  def check_db_health
    check_service_health("DB", MAX_DB_CHECK_SECONDS) do
      ActiveRecord::Base.connection.execute("SELECT 1")
    end
  end
end
