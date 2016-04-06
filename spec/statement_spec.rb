require 'statement'

describe Statement do
  let (:deposit1000) { double :deposit1000, type: :credit,
                      date: (Time.now+2).strftime("%x %H:%m"),
                      amount: 1000, balance: 0}
  let (:deposit2000) { double :deposit2000, type: :credit,
                      date: (Time.now+1).strftime("%x %H:%m"),
                      amount: 2000, balance: 0}
  let (:withdraw500) { double :withdraw500, type: :debit,
                      date: (Time.now).strftime("%x %H:%m"),
                      amount: 500, balance: 0}
  subject(:statement){described_class.new([withdraw500, deposit2000, deposit1000])}
  subject(:empty_statement){described_class.new([])}

  context 'on initialize' do
    it 'has items' do
      expect(statement.items).to be_instance_of(Array)
    end
  end

  context '#print' do
    it { is_expected.to respond_to(:print) }

    it 'prints empty statement if there were no transactions' do
      expect(empty_statement.print).to eq(Statement::PRINT_HEADERS)
    end

    it 'prints current account statement with transactions' do
      body = []
      statement.items.map do |item|
        str  = "#{item.date} ||"
        str += " #{sprintf('%.2f', item.amount) if item.type == :credit} ||"
        str += " #{sprintf('%.2f', item.amount) if item.type == :debit} ||"
        str += " #{sprintf('%.2f', item.balance)}"
        body << str
      end
      print_body = body.join("\n")
      expect(statement.print).to eq(Statement::PRINT_HEADERS + "\n#{print_body}")
    end
  end
end