class HealthController < ApplicationController
  def liveness
    render json: { status: "ok", timestamp: Time.current }, status: :ok
  end
end
