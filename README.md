# E-Commerce Project - Nerdstore

## Rails Commands to generate Models and Controllers

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

## ERD Diagram
<div style="display: block; text-align: center; padding: 1rem; max-width:100%; height:auto;">
    <img src="./docs/ecommerce.png">
</div>
