# Rails Engine
BE Mod 3 Individual Project

![Rails Engine!](https://media2.giphy.com/media/tNmIuKk0kIROM/100.webp?cid=5a38a5a2kcq11xhqmkx9b2pisyzzdw2ffx6y4ch4eu8fwwkn&rid=100.webp)


## Background and Description

The goal of this project was to build an API that exposes data in the requested format.  The idea is that you are building the backend of an E-Commerce application.  The front end and back end of this application are separate and they communicate via APIs.  By building this API and exposing the data, the front end can then use it to build out the front end of the application.  Data has been imported and I have seeded the database for examples.

The main technical skills that we used for this project was to expose an API, use serializers to format JSON responses, test our API exposure, use advanced ActiveRecord queries, and write basic raw SQL statements.  Other skills required was project management, technical research, importing and seeding the database, and reading API documentation, as well as other implicit skills.  For this project, I held true to the principles of Object Oriented Programming, and the development strategy centered around Test-Driven Development.  Rubocop was used to enforce style guidlines.

Below are the endpoints and example responses for the API.


### Table of Contents
***
**[Database Schema](#database-schema)**<br>
**[Merchants](#merchants)**<br>
**[Items](#items)**<br>
**[Relationships](#relationships)**<br>
**[Merchant Search](#merchant-search)**<br>
**[Item Search](#item-search)**<br>
**[Business Intelligence](#business-intelligence)**<br>

***

## Database Schema

![Database Schema](https://user-images.githubusercontent.com/65255478/102554097-51119e00-4081-11eb-9a91-dd89ec735d2e.png)

***

## Merchants

#### Find All Merchants: `GET /api/v1/merchants`
example:
```
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        }
      ]
    }
```
        

#### Find one Merchant: `GET /api/v1/merchants/:id`
example: `http://localhost:3000/api/v1/merchants/5`
```
{
    "data": {
        "id": "5",
        "type": "merchant",
        "attributes": {
            "name": "Williamson Group"
        }
    }
}
```

#### Create a Merchant: `POST /api/v1/merchants`
example:

#### Update a Merchant: `PATCH /api/v1/merchants/:id`
example:

#### Delete a Merchant: `DELETE /api/v1/merchants/:id`
example:  This will not return any data, but you will receive a 204 status to confirm the request processed successfully.

## Items

#### Find All Items: `GET /api/v1/items`
example:

#### Find one Item: `GET /api/v1/items/:id`
example:

#### Create an Item: `POST /api/v1/items`
example:

#### Update an Item: `PATCH /api/v1/items/:id`
example:

#### Delete an Item: `DELETE /api/v1/items/:id`
example:  This will not return any data, but you will receive a 204 status to confirm the request processed successfully.

## Relationships

#### All items associated with a merchant: `GET /api/v1/merchants/:id/items`
example:

#### The merchant associated with an item: `GET /api/v1/items/:id/merchants`
example:

## Merchant Search

#### Return a single record that matches criteria: `GET /api/v1/merchants/find?<attribute>=<value>`
example:

#### Return all records that match criteria: `GET /api/v1/merchants/find_all?<attribute>=<value>`
example:

## Item Search

#### Return a single record that matches criteria: `GET /api/v1/items/find?<attribute>=<value>`
example:

#### Return all records that match criteria: `GET /api/v1/items/find_all?<attribute>=<value>`
example:

## Business Intelligence

#### Return variable munber of merchants ranked by total revenue: `GET /api/v1/merchants/most_revenue?quantity=x`
example:

#### Return variable number of merchants ranked by total items sold: `GET /api/v1/merchants/most_items?quantity=x`
example:

#### Return total revenue across merchants between dates: `GET /api/v1/revenue?start=<start_date>&end=<end_date>`
example:

#### Return the total revenue for a single merchant: `GET /api/v1/merchants/:id/revenue`
example: `http://localhost:3000/api/v1/merchants/1/revenue`
```
{
    "data": {
        "id": null,
        "attributes": {
            "revenue": 528774.6400000005
        }
    }
}
```
