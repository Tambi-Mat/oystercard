=begin
require './lib/oystercard'

card = Oystercard.new

station1 = Station.new("Victoria", 3)

station2 = Station.new("Clapham_junc", 2)

card.balance

card.top_up(20)

p card.balance

card.touch_in(station1)

p card

card.touch_out(station2)

p card
=end
