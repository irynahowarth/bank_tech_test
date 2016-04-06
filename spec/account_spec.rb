require 'account'

describe Account do

  subject(:account){described_class.new}
  subject(:account1000){described_class.new(1000)}

  context 'on initialize' do
    it 'has a balance of zero' do
      expect(account.balance).to eq(0)
    end
    it 'has no transactions' do
      expect(account.transactions).to eq([])
    end
  end

  context '#make_deposit' do
    it { is_expected.to respond_to(:make_deposit).with(1).argument }

    it 'changes balance on deposited amount' do
      expect{ account.make_deposit 1000 }.to change{ account.balance }.by 1000
    end

    it 'adds record of the transaction' do
      account.make_deposit 1000
      expect(account.transactions[0].amount).to eq(1000)
    end
  end

  context '#make_withdraw' do
    it { is_expected.to respond_to(:make_withdraw).with(1).argument }

    it 'changes balance on withdrawed amount' do
      expect{ account1000.make_withdraw 500 }.to change{account1000.balance}.by -500
    end

    it 'adds record of the transaction' do
      account1000.make_withdraw 500
      expect(account1000.transactions[0].amount).to eq(500)
    end

    it 'rais an error when balance is too low to withdraw amount needed' do
      message = "Balance is lower than withdrawing amount"
      expect{ account.make_withdraw 500 }.to raise_error message
    end
  end

end

