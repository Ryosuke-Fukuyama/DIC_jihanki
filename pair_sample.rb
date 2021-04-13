# 稼働例
# irb
# require '/Users/ryosuke.f/workspace/pairwork/pair_sample.rb'
# vm = VendingMachine.new   # 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
#
#
#
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



# ジュースの属性定義
class drink
  attr_reader :name, :price
  def self.coke
    self.new (120, :coke)
  end
  def self.redbull
    self.new (200, :red_bull)
  end
  def self.water
    self.new (100, :water)
  end
  def initialize (price, name)
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
class 	amount
  def initialize
    #一時的に入ってるキャッシュトレー
    @slot_money = slot_money = 0
    #確定キャッシュトレー
    @sale = sale = 0
    @MONEY = MONEY
  end
  def insert(money)
    return puts money unless MONEY.include?(money)
    slot_money += money
  end
  def current_slot_money
    slot_money
  end
  def return_money
    puts slot_money
    slot_money = 0
  end
  def sale_proceeds
    puts sale
  end
end



class stocks
  # 在庫管理(メニュー変更)
  def stock_juice(name, stock)
    button(:name) = (stock).times { Drink.(name) }
    buttons = button(:name)
  end
  def initialize(name)
    @button(:name) = button_(name)
    @buttons = buttons
  end
end


# 表示
class display
  # ジュースの情報を出力
  def store_juice
    puts buttons
  end
  # 購入可能なドリンクの取得
  def choice
    buttons.length.times do |i|
      if buttons[i] != nil
        if slot_money >= @buttons[i][:price]
          return buttons[i][:name]
        end
      end
    end
  end
end


# 各クラスの統合・選択し購入する
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    button_coke = 5.times { Drink.coke }
  end
  # 購入する
  def purchase(name)
    push = button(:name)
    if push.length != nil
      if slot_money >= push[:price]
        slot_money -= push[:price]
        push[:stock] -= 1
        sale += push[:price]
        puts slot_money
      end
    end
  end
end