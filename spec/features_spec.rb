describe 'User Stories' do

  it 'client can make a deposit to the account' do
    account = Account.new
    account.make_deposit(1000)
    expect(account.balance).to eq(1000)
  end

  it 'client can make a withdraw from the account' do
    account = Account.new(500)
    account.make_withdraw(500)
    expect(account.balance).to eq(0)
  end

end