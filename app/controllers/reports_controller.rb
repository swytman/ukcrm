class ReportsController < ApplicationController

  def monthly_counters
    @users = User.select{ |i| i.is?(:settler) && i.village == current_user.village }
    @counters = current_user.village.counters.select{ |i| i.editable_by_settler == true}
  end

end