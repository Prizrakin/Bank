require_relative '../class/account'
require 'mysql2'
class Card
attr_reader :number, :pin, :account, :id

  def initialize(number)
    @number = number
    setdb
    @connect = connect
  end

def none
  !@connect
end

def connect()
  result = @dbclient.query("SELECT * from cards WHERE number = '#{@number}' AND status = 1")
  return false if result.count.zero?
  @number = result.first['number']
  @pin = result.first['pin']
  @account = Account.new(result.first['account_id'])
  @account.connect
  @id = result.first['id']
  true
end



def balance
  @account.sum
end

def block
  result = @dbclient.query("UPDATE cards SET status = 0 WHERE id = #{@id}")
end

private
def setdb()
  host = String('localhost')
  database = String('rubybd')
  username = String('root')
  password = String('V6533521')
  @dbclient = Mysql2::Client.new(:host => host, :username => username, :database => database, :password => password)
end





end



 STDIN.getc
