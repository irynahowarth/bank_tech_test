require 'account'

describe Account do

  context 'on initialize' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  context '#make_deposit' do
    it { is_expected.to respond_to(:make_deposit).with(1).argument }

    it 'changes balance on deposited amount' do
      expect{ subject.make_deposit 1000 }.to change{ subject.balance }.by 1000
    end
  end

  context '#make_withdraw' do
    it { is_expected.to respond_to(:make_withdraw).with(1).argument }

    it 'changes balance on withdrawed amount' do
      subject.make_deposit(500)
      expect{ subject.make_withdraw 500 }.to change{ subject.balance }.by -500
    end

    it 'rais an error when balance is too low to withdraw amount needed' do
      message = "Balance is lower than withdrawing amount"
      expect{ subject.make_withdraw 500 }.to raise_error message
    end
  end

end

