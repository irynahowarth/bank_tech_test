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
  end

  context '#make_withdraw' do
    it { is_expected.to respond_to(:make_withdraw).with(1).argument }

    it 'changes balance on withdrawed amount' do
      expect{ account1000.make_withdraw 500 }.to change{account1000.balance}.by -500
    end

    it 'rais an error when balance is too low to withdraw amount needed' do
      message = "Balance is lower than withdrawing amount"
      expect{ account.make_withdraw 500 }.to raise_error message
    end
  end

  context 'transaction' do

    it 'is added on #make_deposit with type=credit,amount,date,balance' do
      amount_credited = 500
      account.make_deposit(amount_credited)
      transaction = {
        type: 'credit',
        amount: amount_credited,
        date: DateTime.new,
        balance: account.balance
      }
      expect(account.transactions).to eq([transaction])
    end

    it 'is added on #make_withdraw with type=debit,amount,date,balance' do
      amount_debited = 500
      account1000.make_withdraw(amount_debited)
      transaction = {
        type: 'debit',
        amount: amount_debited,
        date: DateTime.new,
        balance: account1000.balance
      }
      expect(account1000.transactions).to eq([transaction])
    end

  end

end

