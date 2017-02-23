module ApplicationHelper
  def format_phone_number(num)
    if num.size > 0
      '(' + num[0..2] + ') ' + num[3..5] + '-' + num[6..9]
    end
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    date = dt.strftime("%a, %b %d %Y")
    time = dt.strftime("%l:%M%P %Z")
    "<strong class='date_bold'>#{date}</strong>".html_safe + " at " + "<strong class='date_bold'>#{time}</strong>".html_safe
  end

  def display_datetime_due(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    date = dt.strftime("%a, %b %d %Y")
    time = dt.strftime("%l:%M%P %Z")
    "<b>Due:</b> <strong class='date_bold'>#{date}</strong>".html_safe + " by " + "<strong class='date_bold'>#{time}</strong>".html_safe
  end

  def format_date(dt)
    dt.strftime("%a, %b %d %Y")
  end

  def display_date(dt)
    "<strong class='date_bold'>#{format_date(dt)}</strong>".html_safe
  end

  def display_date_range(obj)
    "<strong class='date_bold'>#{format_date(obj.start_time)}</strong>".html_safe + "  -  " + "<strong class='date_bold'>#{format_date(obj.end_time)}</strong>".html_safe
  end

  def start_and_end_date_equal?(obj)
    obj.end_time && format_date(obj.start_time) === format_date(obj.end_time)
  end
end
