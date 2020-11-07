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
    # brand = Brand.find_or_create_by(name: brand_name)
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
    # department = Department.find_or_create_by(name: department_name)

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
        # category = department.categories.find_or_create_by(name: category_name)
        generate_products(category_href, category_name) # category)
      end
    else
      categories.each do |cat|
        # parsing data to get Category Name through anchor tag.
        category_name = cat.content
        category_href = cat.attribute("href").to_s
        # Create the category
        # category = department.categories.find_or_create_by(name: category_name)
        generate_products(category_href, category_name) # category)
      end
    end
  end
end

# Brands: each <li> is a brand
# body > header.header-desktop > nav.header-desktop__nav > div.header-desktop__subnav.header-desktop__subnav--main-menu.header-desktop__subnav--todas-as-categorias > div > div.header-desktop__subnav__col.header-desktop__subnav__col--icons > ul > li > ul > li:nth-child(1)
#
# Departments:each li is a department
# body > header.header-desktop > nav.header-desktop__nav > div.header-desktop__subnav.header-desktop__subnav--main-menu.header-desktop__subnav--todas-as-categorias > div > div.header-desktop__subnav__col.header-desktop__subnav__col--departments > div > ul > li
#
# Category: each <li> is one category
# body > main.page-main > div.page-main__container > div.page-archive > div.page-archive__sidebar > div.page-archive__sidebar__item > div:nth-child(1) > ul:nth-child(1) > li:nth-child(1) > ul
# Livros Category:
# body > main.page-main > div.page-main__container > div.page-archive > div.page-archive__sidebar > div.page-archive__sidebar__item > div:nth-child(1) > ul:nth-child(1) > li:nth-child(2) > ul > li
# Last 3 categories
# body > main > div > div.page-archive > div.page-archive__sidebar > div:nth-child(1) > div > a
#
# Products: each li have a product
# body > main > div > div.page-archive > div.page-archive__content > ul > li.product.type-product
# body > main > div > div.page-archive > div.page-archive__content > ul > li.product.type-product.post-715767.status-publish.first.instock.product_cat-camisetas.product_cat-lancamentos.product_cat-lancamentos-2.product_cat-pre-venda.product_cat-presentes.product_cat-homens.product_cat-mulheres.product_cat-namorados.product_cat-pais.product_cat-vestuario.product_tag-azaghal.product_tag-camiseta-unissex.product_tag-camisetas-divertidas.product_tag-jovem-nerd.product_tag-mestre.product_tag-nerdcast.product_tag-para-ela.product_tag-para-ele.product_tag-presente.product_tag-presente-criativo.product_tag-presentes-ate-100-reais.product_tag-presentes-para-chefe.product_tag-presentes-para-irma.product_tag-presentes-para-irmao.product_tag-senhor-k.product_tag-vestimenta.has-post-thumbnail.shipping-taxable.purchasable.product-type-variable
#
# Product Show Page
# Name:
# body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.entry-summary > h1
#
# Description:
# body > main > div.single-product > div.single-product__container > div.type-product > article.single-product__description > div.single-product__description__content
#
# Price:
# body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.entry-summary > p.price
#
# Image:
# body > main > div.single-product > div.single-product__container > div.type-product > div > div.woocommerce-product-gallery.woocommerce-product-gallery--with-images.woocommerce-product-gallery--columns-4.images > div > figure > div.woocommerce-product-gallery__image.flex-active-slide > a > picture > img
# body > main > div.single-product > div.single-product__container > div.type-product > div > div.images > div > figure > div.woocommerce-product-gallery__image.flex-active-slide > a > picture > img
#
# body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.images > div > figure > div > a
#
##########################################
##########################################
# Products:
##########################################
def generate_products(cat_href, category_object)
  # Generate Products
  nerdstore_category_html = open(cat_href).read
  nerdstore_category_doc = Nokogiri::HTML(nerdstore_category_html)

  products_selector = "body > main > div > div.page-archive > div.page-archive__content > ul > li.product.type-product > a"
  products = nerdstore_category_doc.css(products_selector)

  puts "============================================================"
  puts "============ #{category_object} ==============="
  puts "============================================================"

  products.each do |prod|
    prod_href = prod.attribute("href").to_s

    nerdstore_product_html = open(prod_href).read
    nerdstore_product_doc = Nokogiri::HTML(nerdstore_product_html)

    product_name_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.entry-summary > h1"
    product_name = nerdstore_product_doc.css(product_name_selector)

    product_description_selector = "body > main > div.single-product > div.single-product__container > div.type-product > article.single-product__description > div.single-product__description__content"
    product_description = nerdstore_product_doc.css(product_description_selector)

    product_price_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.entry-summary > p.price"
    product_price = nerdstore_product_doc.css(product_price_selector)

    # product_image_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div > div.images > div > figure > div.woocommerce-product-gallery__image.flex-active-slide > a > picture > img"
    # product_image_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.images"
    product_image_selector = "body > main > div.single-product > div.single-product__container > div.type-product > div.single-product__main-info > div.images > figure > div > a"
    product_image = nerdstore_product_doc.css(product_image_selector)
    # #product-713620
    #
    processed_name = product_name[0].content
    processed_name.slice! "Pré-Venda "

    processed_description = product_description[0].content
    processed_description.slice! "Descrição"

    processed_price = product_price[0].content
    processed_price.slice! "R$"
    processed_price = processed_price.gsub(",", ".")

    processed_image_url = product_image[0].attribute("href").to_s

    product_qty = rand_qty
    product_name = processed_name
    product_description = processed_description
    product_price = processed_price

    product_image = processed_name.gsub("–", "").gsub("  ", " ").gsub(" ", "-") + ".jpg"
    puts product_image

    # Create Product
    # prod = Product.create(
    #   name:           product_name,
    #   description:    product_description,
    #   price:          product_price,
    #   stock_quantity: product_qty
    # )
    # Attach Brand
    # prod.brand = brand
    # Attach Category
    # prod.category = cat
    # prod.save

    # Create Image
    # no_image = prod.images.create(path: "image_coming_soon.jpg", position_order: 1)
  end
  puts "#{category_object} found #{products.size} products"
  puts "============================================="
  puts ""
end

##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
# prod = Product.create(
#   name:           "Product Name",
#   description:    "Full product description goes here",
#   price:          price,
#   stock_quantity: qty
# )
##########################################
##########################################
##########################################
def rand_qty
  rand(1..80)
end
##########################################
##########################################

path_to_assets = "../../app/assets/images/Products/"
subpath_after_assets = "TEST-PRODUCT/"
path_to_save = path_to_assets + subpath_after_assets
Dir.mkdir(path_to_save) unless File.exist?(path_to_save)
saved_file_path = path_to_save + "image.jpg"
puts saved_file_path

img_url = "https://nerdstore.com.br/wp-content/uploads/2020/10/camiseta-melhorterpaz-srk-01-2.jpg"
read_image = open(img_url).read
File.open(saved_file_path, "wb") do |file|
  file.write read_image
end

generate_brands_departments
