class RecordController < ApplicationController
  include RecordHelper

  def post
    #Receiver
    record = Record.new(
        collar_id: params[:collar_id],
        frec_cardiaca: params[:frec_cardiaca],
        p_sistolica: params[:p_sistolica],
        p_diastolica: params[:p_diastolica],
        frec_respiratoria: params[:frec_respiratoria],
        longitud: params[:longitud],
        latitud: params[:latitud]
    )

  end

  def get

  end

  def loader
    render :text => "loaderio-9b75a2d089aa19f44f518eea85f61bcd"
  end
end
