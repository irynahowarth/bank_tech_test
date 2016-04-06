class Account
  attr_reader :balance, :transactions

  def initialize(balance=0)
    @transactions = Array.new
    @balance = balance
  end

  def make_deposit(amount)
    create_transaction(:credit, amount, action_name = Transaction)
  end

  def make_withdraw(amount)
    message = 'Balance is lower than withdrawing amount'
    fail message if balance-amount<0
    create_transaction(:debit, amount, action_name = Transaction)
  end

  def print_statement(class_name = Statement)
    statement = class_name.new(transactions)
    statement.print
  end

  private

  def create_transaction(type, amount, action_name)
    transaction = action_name.new(type, amount, balance)
    transaction.make
    @balance = transaction.balance
    record_transaction(transaction)
  end

  def record_transaction(transaction)
    @transactions.insert(0,transaction)
  end

end