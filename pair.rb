# 例
# irb
# require ‘/Users/ryosuke.f/workspace/pairwork’
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money
class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる(slot_moneyに有効値を追加していく)
    @slot_money += money
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @change
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  def sale_proceeds
    puts @sale
  end
end

# 品揃え、値段、在庫の初期設定
# drink_type_and_price_and_stock = [["coke" 120 5], ["Red Bull" 200 5], ["water" 100 5]]
def initialize
  @price = {'coke': 120, 'Red Bull': 200, 'water': 100}
  @stock = {'coke': 5, 'Red Bull': 5, 'water': 5}
end

# 追加格納する
def store
  @stock[:'coke'] + 0
  @stock[:'Red Bull'] + 0
  @stock[:'water'] + 0
end

# 買えるもの表示し、商品を選択する
def button
  @button = ['coke', 'Red Bull', 'water']
  if current_slot_money >= @price[:'Red Bull'] && @stock >= 1
    puts "#{button[0]}, #{button[1]}, #{button[2]}}の中からお選び頂けます。"
    return @button[]
  elsif current_slot_money >= @price[:'coke'] && @stock >= 1
    puts "#{button[0]}, #{button[2]}}の中からお選び頂けます。"
    return @button[]
  elsif current_slot_money >= @price[:'water'] && @stock >= 1
    puts "#{button[2]}}のみお選び頂けます。"
    return @button[]
  else
    puts "購入金が不足しています。"
  end
end

# 購入する
def 	purchase(button)
  if button = 'coke'
    if (current_slot_money >= @price[:'coke']) && (@stock[:'coke'] >= 1)
      @change = current_slot_money - @price[:'coke']
      @stock[:'coke'] - 1
      @sale += @price[:'coke']
      return
    else
      puts "購入金が不足しています。"
    end
  elsif button = 'Red Bull'
    if (current_slot_money >= @price[:'Red Bull']) && (@stock[:'Red Bull'] >= 1)
      @change = current_slot_money - @price[:'Red Bull']
      @stock[:'Red Bull'] - 1
      @sale += @price[:'Red Bull']
      return
    else
      puts "購入金が不足しています。"
    end
  else button = 'water'
    if (current_slot_money >= @price[:'water']) && (@stock[:'water'] >= 1)
      @change = current_slot_money - @price[:'water']
      @stock[:'water'] - 1
      @sale += @price[:'water']
      return
    else
      puts "購入金が不足しています。"
    end
  end
end
