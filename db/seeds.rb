if Rails.env.development?
  AdminUser.create!(email: "admin@gmail.com", password: "asdasd", password_confirmation: "asdasd")
end

puts "Seed script started."
puts "Reseting Products folder"
FileUtils.rm_rf("app/assets/images/Products")
FileUtils.mkdir("app/assets/images/Products")

# Run NerdstoreScraper code
puts "Starting web scrapping"
require File.expand_path("seeds/nerdstore_scraper", __dir__)
puts "Finished web scrapping"
puts "========================="

puts "Created #{Brand.count} Brands"
puts "Created #{Department.count} Departments"
puts "Created #{Category.count} Categories"
puts "Created #{Product.count} Products"
puts "Finished running successfully"
