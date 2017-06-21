class ReportsController < ApplicationController

  def monthly_counters
    @village = current_user.village
    @properties = Property.where(village_id: @village.id)
    @counters = @village.counters.select{ |i| i.editable_by_settler == true}
  end

end