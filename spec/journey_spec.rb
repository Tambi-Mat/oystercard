require 'journey'

describe Journey do

 let(:station) { double(:station, :station_name => 'Bank', :zone => 1) }

  describe '#initialize' do
    it 'is expected to have an entry_station of nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'is expected to have an exit_station of nil' do
      expect(subject.exit_station).to eq nil
    end
  end

  describe '#end_journey' do
    it 'changes exit_station from nil to :station' do
      expect(subject.exit_station).to eq station
    end
  end
end
