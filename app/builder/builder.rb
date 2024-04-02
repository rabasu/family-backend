class Builder
  def datify(date, only_year: false)
    if only_year
      Date.new(date.to_i, 1, 1)
    else
      date.to_date
    end
  end
end
