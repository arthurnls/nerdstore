if Rails.env.development?
  AdminUser.create!(email: "admin@gmail.com", password: "asdasd", password_confirmation: "asdasd")
end

puts "Seed script started."
puts "Reseting Products folder"
FileUtils.rm_rf("storage")
# FileUtils.rm_rf("app/assets/images/Products")
# FileUtils.mkdir("app/assets/images/Products")

# ########################
# Generate Provinces Data
# ########################
province = Province.create(
  name:    "Alberta",
  code:    "AB",
  tax_gst: 5
)
province = Province.create(
  name:    "British Columbia",
  code:    "BC",
  tax_pst: 7,
  tax_gst: 5
)
province = Province.create(
  name:    "Manitoba",
  code:    "MB",
  tax_pst: 7,
  tax_gst: 5
)
province = Province.create(
  name:    "New Brunswick",
  code:    "NB",
  tax_hst: 15
)
province = Province.create(
  name:    "Newfoundland and Labrador",
  code:    "NL",
  tax_hst: 15
)
province = Province.create(
  name:    "Northwest Territories",
  code:    "NT",
  tax_gst: 5
)
province = Province.create(
  name:    "Nova Scotia",
  code:    "NS",
  tax_hst: 15
)
province = Province.create(
  name:    "Nunavut",
  code:    "NU",
  tax_gst: 5
)
province = Province.create(
  name:    "Ontario",
  code:    "ON",
  tax_hst: 13
)
province = Province.create(
  name:    "Prince Edward Island",
  code:    "PE",
  tax_hst: 15
)
province = Province.create(
  name:    "Quebec",
  code:    "QC",
  tax_pst: 9.975,
  tax_gst: 5
)
province = Province.create(
  name:    "Saskatchewan",
  code:    "SK",
  tax_pst: 6,
  tax_gst: 5
)
province = Province.create(
  name:    "Yukon",
  code:    "YT",
  tax_gst: 5
)
# ########################

# ########################
# Run NerdstoreScraper code
# ########################
puts "Starting web scrapping"
require File.expand_path("seeds/nerdstore_scraper", __dir__)
puts "Finished web scrapping"
puts "========================="
# ########################

# ########################
puts "Created #{Province.count} Provinces"
puts "Created #{Brand.count} Brands"
puts "Created #{Department.count} Departments"
puts "Created #{Category.count} Categories"
puts "Created #{Product.count} Products"
puts "Finished running successfully"
