=begin
class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail 'Max balance of #{Oystercard::MAXIMUM_BALANCE} exceeded' if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail 'insuffient credit on card' if balance < 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end

card = Oystercard.new
p card.balance
p card.top_up(90)
p card.balance
p card.deduct(90)
p card.top_up(0)
p card.top_up(0.50)
p card.in_journey
p card.touch_in
=end
