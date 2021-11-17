require_relative '../class/card'


class Terminal


def initialize(number)
  @card = Card.new(number)
  if @card.none
    puts "Карта не действительна"
    stop
  end
  start

end


def start
  @counter = 1
  loop do
    break if @counter > 3
    begin
      #number = getsnumber
      pin = getspin
      raise "Пин не подходит" if pin != @card.pin or pin.length != 4
    rescue RuntimeError => e
      puts "Ошибка: #{ e.message }"
    end
    @counter += 1
    break if @card.pin == pin
  end


  cardblock # роверка попыток входа


  loop do
    puts "1.Показать баланс карты"
    puts "2.Снятие наличных"
    puts "3.Выход"
    comand = gets.chomp.strip.to_i
    balance if comand == 1
    withdraw if comand == 2
    stop if comand == 3
  end

end

def balance
  puts "Средства на карте #{@card.balance}\n"
end

def stop
  puts "Не забудьте забрать карту!"
  exit
end

def cardblock
  return if @counter < 4
  @card.block
  puts "Карта заблокирована"
  stop
end

def withdraw
  puts "Укажите суму которую хотите снять"
  cash = gets.chomp.strip.to_i
  return puts "Не достаточно средств на карте\n" if cash > @card.balance

  @card.account.withdraw(cash)
  puts "Вы сняли со счета cash #{cash}"
  balance

end

def getsnumber
  puts "Введите номер карты :"
  number = gets.chomp.strip
end

def getspin
  puts "Введите pin карты :"
  pin = gets.chomp.strip
end


end
