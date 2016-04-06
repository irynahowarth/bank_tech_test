describe 'User Stories' do

  subject(:account) {Account.new(500)}

  it 'client can make a deposit to the account' do
    account.make_deposit(500)
    expect(account.balance).to eq(1000)
  end

  it 'client can make a withdraw from the account' do
    account.make_withdraw(500)
    expect(account.balance).to eq(0)
  end

  it 'client\'s account records transactions' do
    account.make_deposit(500)
    expect(account.transactions.last).to include(date: Time.now.strftime("%x %H:%m"))
    expect(account.transactions.last).to include(amount: 500)
    expect(account.transactions.last).to include(balance: 1000)
    expect(account.transactions.last).to include(type: 'credit')
  end

  it 'client can print statement of the account' do
    account0 = Account.new
    account0.make_deposit(1000)
    account0.make_deposit(2000)
    account0.make_withdraw(500)
    statement="date || credit || debit || balance\n"
    statement+="#{Time.now.strftime("%x %H:%m")} ||  || 500.00 || 2500.00\\n"
    statement+="#{Time.now.strftime("%x %H:%m")} || 2000.00 ||  || 3000.00\\n"
    statement+="#{Time.now.strftime("%x %H:%m")} || 1000.00 ||  || 1000.00"
    expect(account0.print_statement).to eq(statement)
  end

end