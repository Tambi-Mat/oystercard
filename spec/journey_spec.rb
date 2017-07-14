require 'journey'

describe Journey do

  describe '#initialize' do
    it 'is expected to have an entry_station of nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'is expected to have an exit_station of nil' do
      expect(subject.exit_station).to eq nil
    end
  end
end
