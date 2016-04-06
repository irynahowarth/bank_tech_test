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

  def print_statement
    headers = "date || credit || debit || balance"
    return headers if @transactions.empty?
    headers+"\n"+statement_body_output
  end

  private

  def record_transaction(type, amount)
    type == 'credit'? change_balance(amount) : change_balance(-amount)
    transaction = {
      type: type,
      amount: amount,
      date: Time.now.strftime("%x %H:%m"),
      balance: @balance
    }
    @transactions.insert(0,transaction)
  end

  def change_balance(amount)
    @balance += amount
  end

  def statement_body_output
    statement_body = []
    @transactions.map do |item|
      statement  = "#{item[:date]} || "
      statement += "#{money_format(item[:amount]) if item[:type]=='credit'} || "
      statement += "#{money_format(item[:amount]) if item[:type]=='debit'} || "
      statement += "#{money_format(item[:balance])}"
      statement_body << statement
    end
    statement_body.join('\n')
  end

  def money_format(amount)
    sprintf('%.2f', amount)
  end

end