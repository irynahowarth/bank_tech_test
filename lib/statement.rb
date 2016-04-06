private

class Statement
  PRINT_HEADERS = "date || credit || debit || balance"

  attr_reader :items

  def initialize(items)
    @items = items
  end
  def print
    return PRINT_HEADERS if items.empty?
    PRINT_HEADERS+"\n"+create_body
  end

  private

  def create_body
    body = []
    @items.map do |item|
      body << format_item(item)
    end
    body.join("\n")

  end

  def format_item(item)
    formated =  "#{item.date} || "
    formated += "#{credit?(item)} || "
    formated += "#{debit?(item)} || "
    formated += "#{money_format(item.balance)}"
  end

  def credit?(item)
    money_format(item.amount) if item.type == :credit
  end

  def debit?(item)
    money_format(item.amount)  if item.type == :debit
  end

  def money_format(amount)
    sprintf('%.2f', amount)
  end
end