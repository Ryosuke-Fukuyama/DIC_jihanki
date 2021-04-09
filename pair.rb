# 稼働例
# irb
# require '/Users/ryosuke.f/workspace/pairwork/pair.rb'
# vm = VendingMachine.new     # 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# ⓪vm.slot_money (100)       # 作成した自動販売機に100円を入れる
# 　vm.current_slot_money     # 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# 　vm.return_money           # 作成した自動販売機に入れたお金を返してもらう
# ①vm.slot_money(1)          # 想定外のものが投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
                              # 文字の場合の条件分岐は後日？　"これはお金ではありません"
# ②vm.store_juice            # 格納されているジュースの情報（値段と名前と在庫）を取得できる。
# ③vm.choice                 # 投入金額、在庫の点で、コーラが購入できるかどうかを取得できる。
#   vm.purchase               # ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
#   vm.sale_proceeds          # 現在の売上金額を取得できる。
# ④vm.store                  # ジュースを3種類管理できるようにする。
# ⑤

class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    # 品揃え、値段、在庫の初期設定
    # drink_type_and_price_and_stock = [["coke" 120 5], ["Red Bull" 200 5], ["water" 100 5]]
    @button = [{name: 'coke', price: 120, stock: 5}]
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
    return puts money unless MONEY.include?(money)
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
  # ジュースの情報を出力
  def store_juice
    puts @button
  end
  # 追加格納する
  def store
    @button << {name: 'Red Bull', price: 200, stock: 5}
    @button << {name: 'water', price: 100, stock: 5}
    @button[0][:stock] += 0
    @button[1][:stock] += 0
    @button[2][:stock] += 0
  end
  # 買えるもの表示し、商品を選択する
  def choice 
    if current_slot_money >= @button[1][1] && @button[:stock] >= 1   #在庫の条件分岐を追加する
      puts "#{@button[0][0]}, #{@button[0][1]}, #{@button[0][2]}}の中からお選び頂けます。"
      return @button[] 
    elsif current_slot_money >= @button[1][0] && @button[:stock] >= 1
      puts "#{@button[0][0]}, #{button[0][2]}}の中からお選び頂けます。"
      return @button[]
    elsif current_slot_money >= @button[1][2] && @button[:stock] >= 1
      puts "#{@button[0][2]}}のみお選び頂けます。"
      return @button[]
    else
      # puts "購入金が不足しています。"    # 投入金額が足りない場合もしくは在庫がない場合、購入操作を行っても何もしない。
    end
  end

  # 購入する
  def purchase(button)
    if button == 'coke'
      if (current_slot_money >= @price[:'coke']) && (@stock[:'coke'] >= 1)
        @change = current_slot_money - @price[:'coke']
        @stock[:'coke'] - 1
        @sale += @price[:'coke']
        return
      else
        puts "購入金が不足しています。"
      end
    elsif button == 'Red Bull'
      if (current_slot_money >= @price[:'Red Bull']) && (@stock[:'Red Bull'] >= 1)
        @change = current_slot_money - @price[:'Red Bull']
        @stock[:'Red Bull'] - 1
        @sale += @price[:'Red Bull']
        return
      else
        puts "購入金が不足しています。"
      end
    else button == 'water'
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
end