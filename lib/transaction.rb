private

class Transaction
  attr_reader :amount, :date, :balance, :type

  def initialize(type, amount, balance)
    @type = type
    @amount = amount
    @date = Time.now.strftime("%x %H:%m")
    @balance = balance
  end

  def make
    sign = type == :credit ? 1 : -1
    change_balance(amount*sign)
  end

  private

  def change_balance(amount)
    @balance += amount
  end

end