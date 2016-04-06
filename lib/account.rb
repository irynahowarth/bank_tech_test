class Account
  attr_reader :balance, :transactions

  def initialize(balance=0)
    @transactions = []
    @balance = balance
  end

  def make_deposit(amount)
    record_transaction('credit',amount)
  end

  def make_withdraw(amount)
    message = 'Balance is lower than withdrawing amount'
    fail message if balance-amount<0
    record_transaction('debit',amount)
  end

  private

  def record_transaction(type, amount)
    type == 'credit'? change_balance(amount) : change_balance(-amount)
    transaction = {
      type: type,
      amount: amount,
      date: DateTime.new,
      balance: @balance
    }
    @transactions<< transaction
  end

  def change_balance(amount)
    @balance += amount
  end

end