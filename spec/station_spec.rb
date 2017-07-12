require 'station'

describe Station do
  subject(:station) { described_class.new("Paddington",1)}

  it 'has a name attribute on initialization' do
    expect(station.station_name).to eq "Paddington"
  end

  it 'has a zone attribute on initialization' do
    expect(station.zone).to eq 1
  end
end
