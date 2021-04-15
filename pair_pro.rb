# 稼働例
# irb
# require '/Users/ryosuke.f/workspace/pairwork/pair_pro.rb'
# vm = VendingMachine.new
# vm.insert ()
# vm.return_money
# vm.store(red_bull, 5)
# vm.store(water, 5)
# vm.store_info      在庫確認
# vm.purchasable?    購入可能商品の照会
# vm.purchase()      購入(商品名)
# vm.current_slot_money
# vm.sale_proceeds

class Drink
  attr_reader :name, :price
  def self.coke
    self.new 120, :coke
  end
  def self.red_bull
    self.new 200, :red_bull
  end
  def self.water
    self.new 100, :water
  end
  def initialize price, name
    @name = name
    @price = price
  end
  def hash
    hash = {name: name, price: price}
  end
end

class VendingMachine
  # 失敗
  # attr_reader
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @slot_money = 0
    @sale = 0
    @buttons = []
    @coke = Drink.coke.hash
    @coke[:stock] = 5
    @buttons << @coke
  end
  def insert(money)
    # ?文字のエラー対策?
    return puts money unless MONEY.include?(money)
    @slot_money += money
  end
  def current_slot_money
    @slot_money
  end
  def return_money
    @slot_money
    @slot_money = 0
  end
  def sale_proceeds
    @sale
  end
  def store_info
    @buttons
  end

  # エラー:引数構文ぶっ壊れ
  def store(name, num)
    @name = Drink.name.hash
    @name[:stock] = num
    @buttons << @name
  end
  def purchasable?
    @buttons.each do |button|
      if ( button[:stock] >= 1 ) && ( @slot_money >= button[:price] )
        button[:name]
      end
    end
  end
  # エラー:引数渡し方?
  def purchase(@name)
    if ( @name[:stock] >= 1 ) && ( @slot_money >= @name[:price] )
      @slot_money -= name[:price]
      @name[:stock].to_i -= 1
      @sale += @name[:price]
      @slot_money
    end
  end
end