require "nokogiri"
require "open-uri"

# module NerdstoreScraper
#   # Uncomment this and add the code inside
# end

##########################################
##########################################
# Sample scraping done by Kyle:
# downloaded_image = open(URI.escape("https://source.unsplash.com/600x600/?#{dish.name}"))
# dish.image.attach(io: downloaded_image, filename: "image-#{dish.name}.jpg")

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
def generate_brands_departments
  nerdstore_url = "https://nerdstore.com.br/"
  nerdstore_html = open(nerdstore_url).read
  nerdstore_doc = Nokogiri::HTML(nerdstore_html)

  # Generate Brands
  brands_selector = "body > header.header-desktop > nav.header-desktop__nav > div.header-desktop__subnav.header-desktop__subnav--main-menu.header-desktop__subnav--todas-as-categorias > div > div.header-desktop__subnav__col.header-desktop__subnav__col--icons > ul > li > ul > li"
  brands = nerdstore_doc.css(brands_selector)
  brands.each do |brnd|
    # parsing data to get Brand Name through href.
    href = brnd.at_css("a").attribute("href").to_s
    brand_href = href.split("/").last
    brand_name = brand_href.gsub("-", " ").to_s.titleize

    # Create the brand
    # brand = Brand.find_or_create_by(name: brand_name)

    # GENERATE PRODUCTS
    generate_products(brand)
  end
  # Generate Departments
  departments_selector = "body > header.header-desktop > nav.header-desktop__nav > div.header-desktop__subnav.header-desktop__subnav--main-menu.header-desktop__subnav--todas-as-categorias > div > div.header-desktop__subnav__col.header-desktop__subnav__col--departments > div > ul > li"
  departments = nerdstore_doc.css(departments_selector)
  flag = true
  departments.each do |dep|
    # parsing data to get Department Name through xxx.
    next unless flag

    flag = false
    anchor = dep.at_css("a")
    department_name = anchor.content
    department_href = anchor.attribute("href").to_s

    # Create the department
    # department = Department.find_or_create_by(name: department_name)

    # GENERATE CATEGORIES
  end

  puts brands.size
end

# Brands: each <li> is a brand
# body > header.header-desktop > nav.header-desktop__nav > div.header-desktop__subnav.header-desktop__subnav--main-menu.header-desktop__subnav--todas-as-categorias > div > div.header-desktop__subnav__col.header-desktop__subnav__col--icons > ul > li > ul > li:nth-child(1)
#
##########################################
##########################################
# Products:
##########################################
def generate_products(brand)
  # Generate Products
end
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
generate_brands_departments
