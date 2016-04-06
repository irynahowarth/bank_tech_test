require 'transaction'

describe Transaction do

  let(:amount100){100}
  let(:balance1000){1000}
  subject(:deposit_trans){described_class.new(:credit,amount100, balance1000)}
  subject(:withdraw_trans){described_class.new(:debit,amount100, balance1000)}

  context 'on initialize' do
    it 'has type' do
      expect(deposit_trans.type).to eq(:credit)
      expect(withdraw_trans.type).to eq(:debit)
    end

    it 'has a balance' do
      expect(deposit_trans.balance).not_to be_nil
      expect(withdraw_trans.balance).not_to be_nil
    end

    it 'has an amount' do
      expect(deposit_trans.amount).not_to be_nil
      expect(withdraw_trans.amount).not_to be_nil
    end

    it 'has a date' do
      expect(deposit_trans.date).to eq(Time.now.strftime("%x %H:%m"))
      expect(withdraw_trans.date).to eq(Time.now.strftime("%x %H:%m"))
    end
  end

  context '#make' do
    it { is_expected.to respond_to(:make) }

    it 'changes balance on credited amount' do
      amount=deposit_trans.amount
      expect{deposit_trans.make}.to change{deposit_trans.balance}.by amount
    end

    it 'changes balance on debited amount' do
      amount=withdraw_trans.amount
      expect{withdraw_trans.make}.to change{withdraw_trans.balance}.by -amount
    end

  end
end