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

testB = {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>5},
 "KALE"=>{:price=>3.0, :clearance=>false, :count=>1},
 "BLACK_BEANS"=>{:price=>2.5, :clearance=>false, :count=>1},
 "ALMONDS"=>{:price=>9.0, :clearance=>false, :count=>1},
 "TEMPEH"=>{:price=>3.0, :clearance=>true, :count=>1},
 "CHEESE"=>{:price=>6.5, :clearance=>false, :count=>2},
 "BEER"=>{:price=>13.0, :clearance=>false, :count=>3},
 "PEANUTBUTTER"=>{:price=>3.0, :clearance=>true, :count=>1},
 "BEETS"=>{:price=>2.5, :clearance=>false, :count=>1}}

coups = 	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]

def consolidate_cart(cart)
  newCart = {}

  cart.each {|hash|
    hash.each {|keyz, valz|
      if newCart.has_key?(keyz) == false
        newCart[keyz] = valz
        newCart[keyz][:count] = 1
      else
        newCart[keyz][:count] += 1
      end

    }
  }
  newCart
end

def apply_coupons(cart, coupons)
  coup_cart = {}
  coupons.each {|el|
    #binding.pry
    if cart.has_key?(el.values[0]) == true
      # calculating the number of items from original cart that apply to coupon deal
      c_count = (cart[el.values[0]][:count].to_f) / (el.values[1].to_f)
      # calculating the number of items from original cart that remain and don't apply to coupon deal
      r_count = cart[el.values[0]][:count] - (c_count.floor * el.values[1])
      #binding.pry
      # code for creating new cart item that is the remaining non-coupon applied items in original hash cart
      coup_cart[el.values[0]] = {}
      coup_cart[el.values[0]][:price] = cart[el.values[0]][:price]
      coup_cart[el.values[0]][:clearance] = cart[el.values[0]][:clearance]
      coup_cart[el.values[0]][:count] = r_count
      if c_count.floor > 0
        coup_cart[el.values[0] + " W/COUPON"] = {}
        coup_cart[el.values[0] + " W/COUPON"][:price] = el.values[2]
        coup_cart[el.values[0] + " W/COUPON"][:clearance] = cart[el.values[0]][:clearance]
        coup_cart[el.values[0] + " W/COUPON"][:count] = c_count.floor
      end
      # code for creating new cart item that is the coupon applied items
      # coup_cart[el.values[0] + " W/COUPON"] = {}
      # coup_cart[el.values[0] + " W/COUPON"][:price] = el.values[2]
      # coup_cart[el.values[0] + " W/COUPON"][:clearance] = cart[el.values[0]][:clearance]
      # coup_cart[el.values[0] + " W/COUPON"][:count] = c_count.floor
    else
      next
    end
  }
  cart.each {|keyz, valz|
    if coup_cart.has_key?(keyz) == true
      next
    else
      coup_cart[keyz] = valz
    end
  }
  coup_cart
end

def apply_clearance(cart)
  cartB = {}
  cart.each {|keyz, valz|
    #binding.pry
    if valz[:clearance] == true
      disc_amt = valz[:price] * 0.8
      cartB[keyz] = valz
      cartB[keyz][:price] = disc_amt.round(3)
    else
      cartB[keyz] = valz
    end
  }
  cartB
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  coupon_apply_cart = apply_coupons(cons_cart, coupons)
  discount_apply_cart = apply_clearance(coupon_apply_cart)
  cart_total = 0
  discount_apply_cart.each {|keyz, valz|
    binding.pry
    cart_total += valz[:price]
  }

  if cart_total > 100
    cart_total = cart_total * 0.9
  end

  cart_total
end
#checkout(test, coups)
