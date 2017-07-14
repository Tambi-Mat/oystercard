require_relative 'station'
require_relative 'journey'

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
    raise 'Max balance of #{MAXIMUM_BALANCE} exceeded' if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_name)
    raise 'Insufficient credit on card' if balance < MINIMUM_BALANCE
    journey = Journey.new(station_name)
    @in_journey = true
    @journey_history << journey
    @entry_station = station_name # not sure if needed for now
  end

  def touch_out(station_name)
    @in_journey = false
    deduct(MINIMUM_BALANCE)
    @journey_history.last.end_journey(station_name)
    @exit_station = station_name
=begin
    save_journey
=end
  end

  def in_journey?
    entry_station && !exit_station
  end
=begin
  def save_journey
    @journey_history << {entry: entry_station, exit: exit_station}
  end
=end
  private

    def deduct(amount)
      @balance -= amount
    end


end
