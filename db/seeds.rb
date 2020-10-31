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

prod = cat.products.create(
  name:          "Product Name",
  description:   "Full product description goes here",
  price:         "15",
  stock_quatity: "2"
)
prod.brand << brand

puts "Created #{Product.all.count} products"
puts "Finished running successfully"
