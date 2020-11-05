AdminUser.destroy_all
Product.destroy_all
Brand.destroy_all
Category.destroy_all
Department.destroy_all

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
##########################################

##########################################
##########################################
# Actual Data Scrapping
##########################################
# Brands:
# <div class="header-desktop__subnav__container container">
#   <div class="header-desktop__subnav__col header-desktop__subnav__col--icons">
#     <ul>
#       <li>
#         <span>Compre pela marca</span>
#           <ul>
#             <li style="-webkit-mask-image: url(https://nerdstore.com.br/wp-content/uploads/2020/08/logo-jovem-nerd-1.svg); mask-image: url(https://nerdstore.com.br/wp-content/uploads/2020/08/logo-jovem-nerd-1.svg);">
#               <a href="https://nerdstore.com.br/marca/jovem-nerd/">
#                 <img width="71" height="43" src="https://nerdstore.com.br/wp-content/uploads/2020/08/logo-jovem-nerd.svg" class="attachment-full size-full" alt="">
#               </a>
#
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################

puts "Created #{Product.all.count} products"
puts "Finished running successfully"
