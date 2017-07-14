require 'oystercard'

describe Oystercard do
  let(:station) {double :station} # let declaration defining station as a double

  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
=begin
    before(:each) {subject.top_up(Oystercard::MAXIMUM_BALANCE)}
    # my before(:each) hook, so that i can control opening balance of each object created

    it 'top-up balance upon request' do

      expect(subject.balance).to eq Oystercard::MAXIMUM_BALANCE
    end
=end
    it 'raises an error if maximum top_up balance is reached' do
      max_bal = Oystercard::MAXIMUM_BALANCE # setup of test (usually a class, method, variable)

      subject.top_up(max_bal) # exercise of the test (system under test is executed)

      expect { subject.top_up(1) }.to raise_error 'Max balance of #{MAXIMUM_BALANCE} exceeded' # verify of the test (according to my expectation)
    end
  end

  describe '#deduct' do
    it 'can deduct amount from balance' do
      #subject.deduct(20)
      expect { subject.send :deduct, 20 }.to change { subject.balance }.by -20
      # the .send(:deduct, 20) method will access the private method in the program file
    end
  end

  describe '#in_journey' do
    it { is_expected .to respond_to :in_journey}

    it 'is not intially in journey' do
      subject.in_journey
      expect(subject.in_journey).to eq false
    end
  end

  describe '#touch_in' do
    before(:each) {subject.top_up(Oystercard::MAXIMUM_BALANCE)}
=begin
    before(:each) {subject.touch_in(station)}
=end
    it 'changes in_journey to true with touch_in' do
      expect { subject.touch_in(station) }.to change { subject.in_journey }.to true
    end

    it 'will refuse entry through barriers' do
      allow(subject).to receive(:balance) {0}
      expect { subject.touch_in(station) }.to raise_error 'Insufficient credit on card'
    end

    it 'knows station name on card on touch in' do
      expect(subject.touch_in(station)).to eq station
    end

  end

  describe '#touch_out' do
    before(:each) { subject.top_up(Oystercard::MAXIMUM_BALANCE)}
    before(:each) { subject.touch_in(station)}

    it 'changes in_journey to false with touch_out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey).to eq false
    end

    it 'minimum fee charged on touch_out' do
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by (-Oystercard::MINIMUM_BALANCE)
    end

    it 'station name on card on touch-out' do
      subject.touch_out(station)
      expect(subject.exit_station).not_to be_nil
    end
  end

  describe '#journey_history' do
    before(:each) { subject.top_up(Oystercard::MAXIMUM_BALANCE) }

    it 'is an empty list for history by default' do
      expect(subject.journey_history).to be_empty
    end

=begin
    it 'shows one journey after a single journey in and out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey_history.length).to eq 1
    end
=end
    it 'shows the station entered at begining of journey' do
      subject.touch_in(station)
      expect(subject.journey_history.last.entry_station).to eq station
    end

    it 'shows the station exited at the end of the journey' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey_history.last.exit_station).to eq station
    end
  end

end
