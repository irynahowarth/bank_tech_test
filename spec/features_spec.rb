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
    expect(account.transactions.last).to include(date: DateTime.new)
    expect(account.transactions.last).to include(amount: 500)
    expect(account.transactions.last).to include(balance: 1000)
    expect(account.transactions.last).to include(type: 'credit')
  end

end