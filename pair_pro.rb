# 稼働例
# irb
# require '/Users/ryosuke.f/workspace/pairwork/pair_pro.rb'
# vm = VendingMachine.new   インスタンス化
# vm.slot_money ()   金額を入れる(制限付)
# vm.store(redbull, 5)  在庫追加(レッドブルを5本)
# vm.store(water, 5)  在庫追加(水を5本)
# vm.store_juice    在庫確認
# vm.choice   購入可能商品の照会
# vm.purchase()    商品名で購入
# vm.current_slot_money    現在の投入金額
# vm.sale_proceeds    売上
# vm.return_money   投入金返却

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
  attr_reader
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @slot_money = slot_money
    @sale = sale
    @coke = coke
    @stock = stock
    @buttons = buttons

    slot_money = 0
    sale = 0
    buttons = []
    coke = Drink.coke.hash
    coke[:stock] = 5
    buttons << coke
  end
  def insert(money)
    # !数字以外のもの確認!
    return puts money unless MONEY.include?(money)
    slot_money += money
  end
  def current_slot_money
    slot_money
  end
  def return_money
    slot_money
    slot_money = 0
  end
  def sale_proceeds
    sale
  end
  def store_juice
    buttons
  end

  # 以下引数構文ぶっ壊れ

  def store(name, num)
    name = Drink.name.hash
    name[:stock] = num
    buttons << name
  end
  def choice
    buttons.length.times do |i|
      if ( buttons[i][:stock] >= 1 ) && ( slot_money >= buttons[i][:price] )
        buttons[i][:name]
      end
    end
  end
  def purchase(name)
    if ( name.values_at(:stock) >= 1 ) && ( slot_money >= name.values_at(:price) )
      slot_money -= name.values_at(:price)
      # 配列 - 整数 の状態(要変換！)
      name.values_at(:stock) -= 1
      sale += name.values_at(:price)
      slot_money
    end
  end
end