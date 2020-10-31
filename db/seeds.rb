AdminUser.destroy_all
Product.destroy_all
Brand.destroy_all
Category.destroy_all
Department.destroy_all

if Rails.env.development?
  AdminUser.create!(email: "admin@gmail.com", password: "asdasd", password_confirmation: "asdasd")
end

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

puts "Created #{Product.all.count} products"
puts "Finished running successfully"
