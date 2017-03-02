class RestaurantBill
  attr_accessor :ordered_items, :tip, :total

  def initialize
    @ordered_items = []
  end

  def order_item(item, cost)
    @ordered_items << [item, cost]
  end

  def total
    tax_amount = 0
    amount_without_tax = 0
    amount_with_tax = 0
    @ordered_items.each do |index|
      tax_amount += index[1] * 0.095
      amount_without_tax += index[1]
      amount_with_tax = tax_amount + amount_without_tax
    end
    return amount_with_tax.round(2)
  end

  def tip(amount)
    tip_and_totalcost = total + amount
    return tip_and_totalcost
  end

  def cost_breakdown

    tax = total.round(2) - @ordered_items[0][1].round(2)

    return "Ordered - #{@ordered_items[0][0]}\n" +
           "Which cost - $#{@ordered_items[0][1]}\n" +
           "Tax was - $#{tax.round(2)}\n" +
           "You gave a $#{tip(2) - total} tip\n" +
           "So your total is $#{tip(2).round(2)}"
  end

end
#return_message = RestaurantBill.new
#puts "#{return_message.cost_breakdown}"
