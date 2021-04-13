# 稼働例
# irb
# require '/Users/ryosuke.f/workspace/pairwork/pair.rb'
# vm = VendingMachine.new   # 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# ⓪
# vm.slot_money(100)        # 作成した自動販売機に100円を入れる
# vm.current_slot_money     # 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.return_money           # 作成した自動販売機に入れたお金を返してもらう
# ①
# vm.slot_money(1)          # 想定外のものが投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
                            # 文字の場合の条件分岐は後日？　"これはお金ではありません"
# ②
# vm.store_juice            # 格納されているジュースの情報（値段と名前と在庫）を取得できる。
# ③
# vm.choice                 # 投入金額、在庫の点で、コーラが購入できるかどうかを取得できる。
# vm.purchase               # ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
# vm.current_sale_proceeds  # 現在の売上金額を取得できる。
# ④
# vm.store0                 # ジュースを3種類管理できるようにする。
# ⑤
# vm.purchase(0~2)          # 購入するジュースを選択し、釣り銭を出力する。


# 各クラスの統合・選択し購入する
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    5.times { store Drink.cola }
  end
  # ジュースの情報を出力
  def store_juice
    puts @button
  end
  # 購入する
  def purchase(button)
    if @buttons[button][:stock] >= 1
      if current_slot_money >= @buttons[button][:price]
        @slot_money -= @buttons[button][:price]
        @buttons[button][:stock] -= 1
        @sale += @buttons[button][:price]
        puts slot_money
      end
    end
    if @button == (0 || 1  || 2)
      puts 選択し直して下さい。
    end
  end
end


# ジュースの属性定義
class juice
  attr_reader :name, :price
  def self.cola
    self.new 120, :cola
  end
  def self.redbull
    self.new 200, :redbull
  end
  def self.water
    self.new 100, :water
  end
  def initialize price, name
    @name = name
    @price = price
  end
  def hash
    name.hash
  end
  def to_s
    "<Drink: name=#{name}, price=#{price}>"
  end
end


# お金の増減管理
class slot_money
  #一時的に入ってる
  @slot_money = 0
  #確定
  @sale = 0
  def insert(money)
    return puts money unless MONEY.include?(money)
    @slot_money += money
  end
  def current_slot_money
    @slot_money
  end
  def return_money
    puts @slot_money
    @slot_money = 0
  end
  def sale_proceeds
    puts @sale
  end
end


# 在庫の増減管理
class store
  def stock_juice(name, stock)
    @button_(name) = (stock)
  end
end
# 表示


class display
  @buttons.length.times do |i|
    if @buttons[i][:stock] != 0
      if current_slot_money >= @buttons[i][:price]
        @buttons[i][:name]
       end
     end
  end
end