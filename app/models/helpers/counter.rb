class Helpers::Counter

  def self.current_month_counters(property, editable_by_setter = true)
    waiting_month = Helpers::Month.waiting_month
    result = {}
    counters = property.village.counters.where(editable_by_settler: editable_by_setter)
    counters.each do |c|
      result[c.id] = c.meterings.where(property_id: property.id, month: waiting_month[:month], year: waiting_month[:year]).
          order('year DESC, month DESC').try(:first)
    end
    result
  end

  def self.waiting_counters(property)
    waiting_month = Helpers::Month.waiting_month
    result = {}
    send_required = false
    counters = property.village.counters.where(:editable_by_settler => true)
    counters.each do |c|
      result[c.id] = c.meterings.where(property_id: property.id, month: waiting_month[:month], year: waiting_month[:year]).
          order('year DESC, month DESC').try(:first)
      send_required = true unless result[c.id].present?
    end
    if send_required
      result
    else
      false
    end
  end

end