10.times do
  Product.create name: FFaker::Product.product_name, price: rand(1000), description: FFaker::Lorem.paragraph
end
