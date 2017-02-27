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

  def self.waiting_month
    now = DateTime.now
    day = now.day
    month = now.month
    year = now.year
    if day > 20
      return {month: month, year: year}
    else
      return prev_month(month, year)
    end
  end

end
