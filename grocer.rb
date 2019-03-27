require "pry"

test = 	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
    {"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
    {"BEER" => {:price => 13.00, :clearance => false}},
    {"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]

coups = 	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]

def consolidate_cart(cart)
  newCart = {}

  cart.each {|hash|
    hash.each {|keyz, valz|
      #binding.pry
      if newCart.has_key?(keyz) == false
        newCart[keyz] = valz
        newCart[keyz][:count] = 1
      else
        newCart[keyz][:count] += 1
      end

    }
  }
  binding.pry
  newCart
end
consolidate_cart(test)
def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
