require "nokogiri"
require "open-uri"
require_relative "translate"

##########################################
##########################################
# Data Scrapping from nerdstore.com.br
##########################################
def generate_brands_departments
  nerdstore_url = "https://nerdstore.com.br/"
  nerdstore_html = open(nerdstore_url).read
  nerdstore_doc = Nokogiri::HTML(nerdstore_html)

  ######################
  # Generate Brands
  brands_selector = "body > header.header-desktop > nav.header-desktop__nav > div.header-desktop__subnav.header-desktop__subnav--main-menu.header-desktop__subnav--todas-as-categorias > div > div.header-desktop__subnav__col.header-desktop__subnav__col--icons > ul > li > ul > li"
  brands = nerdstore_doc.css(brands_selector)
  brands.each do |brnd|
    # parsing data to get Brand Name through href.
    href = brnd.at_css("a").attribute("href").to_s
    brand_href = href.split("/").last
    brand_name = brand_href.gsub("-", " ").to_s.titleize

    # Create the brand
    brand = Brand.find_or_create_by(name: translate(brand_name))
  end
  ######################
  # Generate Departments
  departments_selector = "body > header.header-desktop > nav.header-desktop__nav > div.header-desktop__subnav.header-desktop__subnav--main-menu.header-desktop__subnav--todas-as-categorias > div > div.header-desktop__subnav__col.header-desktop__subnav__col--departments > div > ul > li"
  departments = nerdstore_doc.css(departments_selector)
  departments.each do |dep|
    # parsing data to get Department Name through anchor tag.
    anchor = dep.at_css("a")
    department_name = anchor.content
    department_href = anchor.attribute("href").to_s

    # Create the department
    department = Department.find_or_create_by(name: translate(department_name))

    ######################
    # Generate Categories
    nerdstore_department_html = open(department_href).read
    nerdstore_department_doc = Nokogiri::HTML(nerdstore_department_html)

    if department_name == "Livros"
      categories_selector = "body > main.page-main > div.page-main__container > div.page-archive > div.page-archive__sidebar > div.page-archive__sidebar__item > div:nth-child(1) > ul:nth-child(1) > li:nth-child(2) > ul > li > a"
    elsif (department_name == "Acessórios") || (department_name == "Colecionáveis") || (department_name == "Kits")
      categories_selector = "body > main > div > div.page-archive > div.page-archive__sidebar > div:nth-child(1) > div > a"
    else
      categories_selector = "body > main.page-main > div.page-main__container > div.page-archive > div.page-archive__sidebar > div.page-archive__sidebar__item > div:nth-child(1) > ul:nth-child(1) > li:nth-child(1) > ul > li > a"
    end

    categories = nerdstore_department_doc.css(categories_selector)
    if (department_name == "Acessórios") || (department_name == "Colecionáveis") || (department_name == "Kits")
      categories.each do |cat|
        # parsing data to get Category Name through anchor tag.
        category_name = cat.content
        category_href = "https://nerdstore.com.br" + cat.attribute("href").to_s
        # Create the category
        category = department.categories.find_or_create_by(name: translate(category_name))
        generate_products(category_href, category) # category)
      end
    else
      categories.each do |cat|
        # parsing data to get Category Name through anchor tag.
        category_name = cat.content
        category_href = cat.attribute("href").to_s
        # Create the category
        category = department.categories.find_or_create_by(name: translate(category_name))
        generate_products(category_href, category) # category)
      end
    end
  end
end

##########################################
##########################################
# Products:
##########################################
def generate_products(cat_href, category_object)
  all_brands = Brand.all
  # Generate Products
  nerdstore_category_html = open(cat_href).read
  nerdstore_category_doc = Nokogiri::HTML(nerdstore_category_html)

  products_selector = "body > main > div > div.page-archive > div.page-archive__content > ul > li.product.type-product > a"
  products = nerdstore_category_doc.css(products_selector)

  # Go inside each product URL to scrape product data
  products.each do |prod|
    prod_href = prod.attribute("href").to_s

    begin
      nerdstore_product_html = open(prod_href).read
    rescue Exception => e
      next
    end
    nerdstore_product_doc = Nokogiri::HTML(nerdstore_product_html)

    ####################
    # Scrape data
    # Scrape Product Name
    product_name_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.entry-summary > h1"
    product_name = nerdstore_product_doc.css(product_name_selector)

    # Scrape Product Description
    product_description_selector = "body > main > div.single-product > div.single-product__container > div.type-product > article.single-product__description > div.single-product__description__content"
    product_description = nerdstore_product_doc.css(product_description_selector)

    # Scrape Product Price
    product_price_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.entry-summary > p.price"
    product_price = nerdstore_product_doc.css(product_price_selector)

    # Scrape Product first Image
    product_image_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.images > figure > div > a"
    product_image = nerdstore_product_doc.css(product_image_selector)

    ####################
    # Process data
    processed_name = product_name[0].content
    processed_name.slice! "Pré-Venda "
    processed_name = processed_name.gsub!(/[^0-9A-zÀ-ú\s]/, "-")

    processed_description = product_description[0].content
    processed_description.slice! "Descrição"

    processed_price = product_price[0].content
    processed_price.slice! "R$"
    processed_price = processed_price.gsub(",", ".")

    processed_image_url = product_image[0].attribute("href").to_s

    ####################
    # Setup processed data input
    product_qty = rand_qty
    product_name = processed_name
    product_description = processed_description
    product_price = processed_price.to_d

    next if processed_name.nil?

    product_image = processed_name.gsub!(/[^0-9A-zÀ-ú\s]/, "").gsub("  ", " ").gsub(" ", "-") + ".jpg"

    ####################
    # Create Product
    created_product = Product.create(
      name:           product_name,
      description:    product_description,
      price:          product_price,
      stock_quantity: product_qty
    )
    # Attach Brand
    brand_index_size = all_brands.size - 1
    brand_index = rand(0..brand_index_size)
    created_product.brand = all_brands[brand_index]
    # Attach Category
    created_product.category = category_object
    created_product.save
    # If creating the product fails because of validation, skip to next iteration
    next unless created_product.valid?

    ##############################################
    # Process image URL and download image.
    # Image will be added inside assets/images/Products/{product_name}/{image_path}
    ##############################################
    path_to_assets = "app/assets/images/Products/"
    subpath_after_assets = created_product.name.gsub(" ", "-") + "/"
    path_to_save = path_to_assets + subpath_after_assets
    Dir.mkdir(path_to_save) unless File.exist?(path_to_save)
    # Set file path to save
    saved_file_path = path_to_save + product_image
    begin
      # download image and save
      read_image = open(processed_image_url).read
      File.open(saved_file_path, "wb") do |file|
        file.write read_image
      end
      # Create Image
      created_product.images.create(path: product_image, position_order: 1)
    rescue Exception => e
      # If got here, was unable to download the image. Create the default "image_coming_soon.jpg"
      read_image = open("app/assets/images/image_coming_soon.jpg").read
      File.open(saved_file_path, "wb") do |file|
        file.write read_image
      end
      # Create Image
      created_product.images.create(path: path_to_save, position_order: 1)
    end
    ##############################################
  end
end

def rand_qty
  rand(1..80)
end

generate_brands_departments

# TO DO:
# Finish building translate function
# Use translate function to translate all categories, departments, brands to english
# Run rails db:reset again
# puts translate("Livros")
