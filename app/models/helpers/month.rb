class Helpers::Month

  def self.next_month(month, year)
    if month.to_i < 12
      return { month: month+1, year: year }
    end

    if month.to_i == 12
      return { month: 1, year: year + 1 }
    end
  end

  def self.prev_month(month, year)
    if month.to_i == 1
      return { month: 12, year: year-1 }
    end

    if month.to_i > 1
      return { month: month - 1, year: year }
    end
  end

  def self.compare(date1, date2)
    return -1 if date1[:year] < date2[:year]
    return 1 if date1[:year] > date2[:year]
    return -1 if date1[:month] < date2[:month]
    return 1 if date1[:month] > date2[:month]
    return 0
  end

end
