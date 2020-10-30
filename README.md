# E-Commerce Project - Nerdstore

## Rails Commands to generate Models and Controllers

- Commands used to generate the Models:
    - rails g model Type name:string
    - rails g model Genre name:string
    - rails g model Director name:string
    - rails g model Actor name:string
    - rails g model User name:string age:string
    - rails g model NetflixTitle title:string description:text date_added:date release_year:integer rating:string duration:string type:references
    - rails g model Movie title:string description:text release_date:date release_year:integer duration:integer average_vote:float votes:integer
- Relationship Models
    - rails g model UserNetflixTitle user:references netflix_title:references

## ERD Diagram
<div style="display: block; text-align: center; padding: 1rem; max-width:100%; height:auto;">
    <img src="./docs/ecommerce.png">
</div>
