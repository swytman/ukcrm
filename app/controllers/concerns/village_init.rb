module VillageInit
  extend ActiveSupport::Concern


  def set_village_for_index

    return if @village

    if current_user.is?(:administrator, :manager)
      @village = Village.find_by(id: params[:village_id])
    else
      @village = current_user.village

    end
  end


end