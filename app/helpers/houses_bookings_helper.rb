module HousesBookingsHelper
  def month_link(month_date)
    params.merge!({:date => { :month => month_date.month, :year => month_date.year}})
    link_to(l(month_date, :locale => :hu, :format => :wo_day),
            params, :class => 'month_link')
  end

  # custom options for this calendar
  def event_calendar_opts
    {
      :first_day_of_week => @first_day_of_week,
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => l(@shown_month, :format => :wo_day, :locale => :hu),
      :previous_month_text => "<< " + month_link(@shown_month.last_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>",
      :use_all_day => true
    }
  end

  def event_calendar
    calendar event_calendar_opts do |args|
      event, day = args[:event], args[:day]
#       logger.info 'event.inspect = ' + event.inspect
      html =  link_to( event.name + ' ' + event.status, booking_path(event.booking_id))    # %(<a href="/houses_bookings/#{event.id}" title="#{h(event.name)}">)
      html << event.name + ' ' + event.status
#      html << day.strftime('%Y.%m.%d')
      html << %(</a>)
      html
    end
  end

  def houses_links(houses)
    houses.map do |house|
      link_to(house.code, house_path(house.id))
    end.join(', ')
  end

  def hb_links(hbs)
    hbs.map do |hb|
      link_to(hb.code, houses_booking_path(hb.id))
    end.join(', ')
  end
end
