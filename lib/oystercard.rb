class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journey_history
  # attr_accessor :in_journey or attr_reader???

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = []
  end

  def top_up(amount)
    fail 'Max balance of #{Oystercard::MAXIMUM_BALANCE} exceeded' if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station_name)
    raise 'Insufficient credit on card' if balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station_name
  end

  def touch_out(station_name)
    @in_journey = false
    deduct(MINIMUM_BALANCE)
    @exit_station = station_name
    save_journey
  end

  def in_journey?
    entry_station && !exit_station
  end

  def save_journey
    @journey_history << {entry: entry_station, exit: exit_station}
  end

end
