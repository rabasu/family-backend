class HorsesController < ApplicationController
  # race_horseの馬を一覧表示
  def index
    @horses = Horse.where(group: :race_horse)
    json_string = HorseSerializer.new(@horses, options).serializable_hash.to_json
    render json: json_string
  end

  # race_horseの馬を個別表示
  def show
    @horse = Horse.find(params[:id])
    json_string = HorseSerializer.new(@horse).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    options = {}
    options[:include] = %i[sire dam family_line awardings]
    options
  end
end
