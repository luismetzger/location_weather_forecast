module HomeHelper
  def wk_day(date)
    time = Time.at(date.to_time)

    case time.wday
    when 0
      'Sunday'
    when 1
      'Monday'
    when 2
      'Tuesday'
    when 3
      'Wednesday'
    when 4
      'Thursday'
    when 5
      'Friday'
    when 6
      'Saturday'
    end
  end

  def is_cached?
    Rails.cache.read('forecast_results').present?
  end
end
