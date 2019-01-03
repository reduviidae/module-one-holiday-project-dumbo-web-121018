# determines user mood
def user_total_score
  user = User.all.find_by(logged_in: true)

  score_sum = user.quotes.sum(:score)
  magnitude_sum = user.quotes.sum(:score)
  quote_count = user.quotes.length
  score = score_sum / quote_count
  magnitude = magnitude_sum / quote_count

  positive_count = user.quotes.where("sentiment = 'positive'").count
  negative_count = user.quotes.where("sentiment = 'negative'").count
  neutral_count = user.quotes.where("sentiment = 'neutral'").count

  if score > 0.5 && magnitude > 0.5
    puts "Based on this sample of quotes, it would seem that #{user.name} is very positive!"
  elsif score > 0.1 && magnitude > 0.2
    puts "Based on this sample of quotes, it would seem that #{user.name} is somewhat positive."
  elsif score < 0 && magnitude > 0.5
    puts "Based on this sample of quotes, it would seem that #{user.name} is very negative."
  elsif score < 0 && magnitude > 0.2
    puts "Based on this sample of quotes, it would seem that #{user.name} is somewhat negative."
  elsif (0..0.19).include?(magnitude)
    puts "Based on this samle of quotes, it would seem that #{user.name} is pretty neutral"
  else (0...0.1).include?(score) && magnitude > 0.2
    puts "Based on this samle of quotes, it would seem that #{user.name} is a mixed bag!"
  end
  puts "Score: #{score}"
  puts "Magnitude: #{magnitude}"
  puts "#{user.name} has liked #{positive_count} positive quotes, #{negative_count} negative quotes, and #{neutral_count} neutral quotes."
  menu
end