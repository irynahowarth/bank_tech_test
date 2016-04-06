class Account
  attr_reader :balance

  def initialize(balance=0)
    @balance = balance
  end

  def make_deposit(amount)
    @balance += amount
  end

  def make_withdraw(amount)
    fail 'Balance is lower than withdrawing amount' if balance-amount<0
    @balance -= amount
  end
end