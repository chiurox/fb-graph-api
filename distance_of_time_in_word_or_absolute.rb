require 'date'

def distance_of_time_in_words_or_absolute(datetime)
  datetime_difference = Time.now - datetime.to_time
  return datetime.strftime("%m/%d/%Y at %I:%M%p") if datetime_difference > 60*60*24*2
  secs = datetime_difference.to_int
  mins = secs / 60
  hours = mins / 60
  days = hours / 60
  if days > 0
    "#{days} day and #{hours % 24} hours ago"
  elsif hours > 0
    "#{hours} hours and #{mins % 60} minutes ago"
  elsif mins > 0
    "#{mins} minutes and #{secs % 60} seconds ago"
  elsif secs >= 0
    "#{secs} seconds ago"
  end
end