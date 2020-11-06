if Rails.env.development?
  AdminUser.create!(email: "admin@gmail.com", password: "asdasd", password_confirmation: "asdasd")
end

##########################################
# A few sample initial data
##########################################
dep = Department.create(name: "Department Name")
cat = dep.categories.create(name: "Category Name")
brand = Brand.create(name: "Brand Name")

price = 15.49
qty = 2
prod = Product.create(
  name:           "Product Name",
  description:    "Full product description goes here",
  price:          price,
  stock_quantity: qty
)
prod.brand = brand
prod.category = cat
prod.save
no_image = prod.images.create(path: "image_coming_soon.jpg", position_order: 1)

prod2 = Product.create(
  name:           "Another Product",
  description:    "Full product2 description goes here",
  price:          price + 1,
  stock_quantity: qty + 1
)
prod2.brand = brand
prod2.category = cat

prod2.save

puts "Created #{Product.all.count} products"
puts "Finished running successfully"

# Run NerdstoreScraper code
require File.expand_path("seeds/nerdstore_scraper", __dir__)
