require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/restaurant_bill'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

describe RestaurantBill do

  before do
    @my_bill = RestaurantBill.new
  end
  it "A Bill is created with an empty ordered_items" do

    @my_bill.ordered_items.must_be_instance_of Array
    @my_bill.ordered_items.empty?.must_equal true
    # or could be written
    # @my_bill.ordered_items.lenght.must_equal 0
  end

  it "order_item method should include add things to ordered_items array" do
    new_item = @my_bill.order_item("dog", 2)
    @my_bill.ordered_items.must_equal new_item
  end

  it "ordered_items array will have three times when three items are added" do

    @my_bill.order_item("dog", 2)
    @my_bill.order_item("cat", 3)
    @my_bill.order_item("fish", 4)
    @my_bill.ordered_items.length.must_equal 3

  end

  it "total method that returns a total of all the item's costs combined, with tax" do
    # loop through ordered_items, collect the second thing in every array and add them together
    @my_bill.order_item("Cookie", 2.0)
    @my_bill.order_item("Noodles", 3.0)
    @my_bill.order_item("Salad", 4.0)

#instead of .must_equal, you should probably do .must_be_within_delta when dealing with floats
    @my_bill.total.must_equal 9.86

  end

  it "add_tip method that will add a tip amount to  if customer wants to" do
    @my_bill.order_item("Cookie", 2.0)
    @my_bill.order_item("Noodles", 3.0)
    @my_bill.order_item("Salad", 4.0)

    @my_bill.tip(5).must_equal 14.86

  end
  it "Tells total cost of bill with cost and tip" do
    new_order_item = @my_bill.order_item("Bread", 5)
    tax = @my_bill.total.round(2) - new_order_item[0][1].round(2)


    @my_bill.cost_breakdown.must_be_kind_of String, "Ordered - #{new_order_item[0][0]}\n" +
           "Which cost - $#{new_order_item[0][1]}\n" +
           "Tax was - $#{tax.round(2)}\n" +
           "You gave a $#{@my_bill.tip(2) - @my_bill.total} tip\n" +
           "So your total is $#{@my_bill.tip(2).round(2)}"
  end

end
