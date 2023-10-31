require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  def new_product(title: "AAAAA", desc: "BBBB", image_url: "zzz.jpg", price: 0.01)
    Product.new(title: title, description: desc, image_url: image_url, price: price)
  end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = new_product()
    
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
      
    product.price = 0
    assert product.invalid? 
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    # @todo Interesting test case - product.invalid? returns false when it should be true at the boundary
    # product.price = 0.00999
    # assert product.invalid? 
    # assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0.01
    assert product.valid?

    product.price = 1
    assert product.valid?
  end

  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c.d/x/y/z/more/fred.gif}
    bad = %w{ fred.doc fred.pdf fred.png/more FRED.JPG.more FRED.Jpggif http://a.bfred.gif/more}

    ok.each do |image_url|
      assert new_product(image_url: image_url).valid?, "#{image_url} must be valid"
    end

    bad.each do |image_url|
      assert new_product(image_url: image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1.0, image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]

  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1.0, image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]

  end



end
