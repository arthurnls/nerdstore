# E-Commerce Project - Nerdstore

## Pages Planning

- Page Page
    - **"/"**
    - `product#index`
    - Shows a select number of products from within a few categories
    - **"/account"**
    - `controller#account`
    - When not logged in: Shows the account page, where it will show login and register forms.
    - When logged in: Shows the profile page, with an `Orders` tab and a `Account Profile` tab
    - **"/about"**
    - `controller#about`
    - Shows the about page
    - **"/contact"**
    - `controller#contact`
    - Shows the contact page
    - **"/cart"**
    - `controller#cart`
    - Shows the cart content
    - **"/checkout"**
    - `controller#checkout`
    - Goes to the checkout workflow
- Department Page
    - **"/department/{name}"**
    - `controller#show`
    - We only need the show page. The show page will show items that belongs to that department, and a submenu in the side with all categories from this department
- Category Page
    - **"/category"**
    - `controller#index`
    - **"/category/{name}"**
    - `controller#show`
    - We only need the index and show pages.
    - The index page will redirect to this category's `department#show` page.
    - The show page will show items that belongs to that category, and a submenu in the side with all categories from this department
- Product Page
    - **"/"**
    - `controller#index`
    - **"/product/{name}"**
    - `controller#show`
    - We only need the index and show pages.
    - Index page will be the landing page.
    - Show page shows that specific product with details



## Rails Commands to generate Models and Controllers

### Models

- Commands used to generate the Models:
    - rails g model Province code:string name:string
    - rails g model Customer name:string email:string password:string address_line:string city:string postal_code:string country:string province:references
    - rails g model Brand name:string
    - rails g model Department name:string
    - rails g model Category name:string department:references
    - rails g model Product name:string description:text price:decimal stock_quatity:integer brand:references category:references
    - rails g model Image path:string position_order:integer product:references
    - rails g model Order cost_shipping:decimal cost_GST:decimal cost_PST:decimal cost_HST:decimal cost_discount:decimal shipping_address:string
- Relationship Models
    - rails g model OrderDetail customer:references order:references quatity:integer purchase_price:decimal

### Controllers

- Commands used to generate Controllers
    - rails g controller houses index show

## ERD Diagram
<div style="display: block; text-align: center; padding: 1rem; max-width:100%; height:auto;">
    <img src="./docs/ecommerce.png">
</div>
