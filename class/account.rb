require 'mysql2'


class Account
attr_reader :id, :sum, :code
  def initialize (account_id)
    @id = account_id
    setdb
  end


  def connect
    result = @dbclient.query("SELECT * from accounts WHERE id = #{@id}")
    return false if result.count.zero?
    @sum = result.first['sum']
    @code = result.first['code']
  end

def withdraw (cash)
  @sum -= cash
  result = @dbclient.query("UPDATE accounts SET sum = #{@sum} WHERE id = #{@id}")
end

  private
  def setdb
    host = String('localhost')
    database = String('rubybd')
    username = String('root')
    password = String('V6533521')
    @dbclient = Mysql2::Client.new(:host => host, :username => username, :database => database, :password => password)
  end



end
