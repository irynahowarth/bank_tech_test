require 'account'

describe Account do

  subject(:account){described_class.new}
  subject(:account1000){described_class.new(1000)}
  let (:credit_500) { double :credit_500,
                      type: 'credit',
                      amount: 500,
                      balance: 0}

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

  context '#print_statement' do

    xit 'prints empty statement if there were no transactions' do
      statement = "date || credit || debit || balance"
      expect(account.print_statement).to eq(statement)
    end

    xit 'prints current account statement after transaction' do
      amount_credited = 500
      account.make_deposit(amount_credited)
      statement = "date || credit || debit || balance\n"
      statement += "#{Time.now.strftime("%x %H:%m")} || "
      statement += "#{sprintf('%.2f', amount_credited)} || "
      statement += " || "
      statement += "#{sprintf('%.2f', account.balance)}"
      expect(account.print_statement).to eq(statement)
    end

    xit 'prints current account statement in descending order' do
      account.make_deposit(2000)
      account.make_withdraw(500)
      statement = "date || credit || debit || balance\n"
      statement+="#{Time.now.strftime("%x %H:%m")} ||  || 500.00 || 1500.00\\n"
      statement+="#{Time.now.strftime("%x %H:%m")} || 2000.00 ||  || 2000.00"
      expect(account.print_statement).to eq(statement)
    end

  end

end

