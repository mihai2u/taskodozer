{ 
 :short_date   => lambda { |time| time.strftime("%b #{time.day.ordinalize} '%y") },  # Nov 7th '10
 :long_date   => "%a, %b %d, %Y",    # Tue, Apr 13, 2010,
 :short_time => lambda { |time| time.strftime("%b #{time.day.ordinalize} '%y at %H:%M") }  # Nov 7th '10 at 14:23
}.each do |format_name, format_string|
  Time::DATE_FORMATS[format_name] = format_string
end
