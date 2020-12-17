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
example: `http://localhost:3000/api/v1/merchants`
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
example: `http://localhost:3000/api/v1/merchants?name=New Merchant`
```
{
    "data": {
        "id": "129",
        "type": "merchant",
        "attributes": {
            "name": "New Merchant"
        }
    }
}
```

#### Update a Merchant: `PATCH /api/v1/merchants/:id`
example: `http://localhost:3000/api/v1/merchants/5?name=New Name`
```
{
    "data": {
        "id": "5",
        "type": "merchant",
        "attributes": {
            "name": "New Name"
        }
    }
}
```

#### Delete a Merchant: `DELETE /api/v1/merchants/:id`
example:  This will not return any data, but you will receive a 204 status to confirm the request processed successfully.

## Items

#### Find All Items: `GET /api/v1/items`
example: `http://localhost:3000/api/v1/items`
```
{
    "data": [
        {
            "id": "4",
            "type": "item",
            "attributes": {
                "name": "Item Nemo Facere",
                "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.",
                "unit_price": 42.91,
                "merchant_id": 1
            }
        },
        {
            "id": "6",
            "type": "item",
            "attributes": {
                "name": "Item Provident At",
                "description": "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.",
                "unit_price": 159.25,
                "merchant_id": 1
            }
        },
```        

#### Find one Item: `GET /api/v1/items/:id`
example: `http://localhost:3000/api/v1/items/5`
```
{
    "data": {
        "id": "5",
        "type": "item",
        "attributes": {
            "name": "New Name",
            "description": "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.",
            "unit_price": 687.23,
            "merchant_id": 1
        }
    }
}
```

#### Create an Item: `POST /api/v1/items`
example: `http://localhost:3000/api/v1/items?name=New Name&description=Something new&unit_price=10.99&merchant_id=1`
```
{
    "data": {
        "id": "2527",
        "type": "item",
        "attributes": {
            "name": "New Name",
            "description": "Something new",
            "unit_price": 10.99,
            "merchant_id": 1
        }
    }
}
```

#### Update an Item: `PATCH /api/v1/items/:id`
example:`http://localhost:3000/api/v1/items/5?name=New Name`
```
{
    "data": {
        "id": "5",
        "type": "item",
        "attributes": {
            "name": "New Name",
            "description": "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.",
            "unit_price": 687.23,
            "merchant_id": 1
        }
    }
}
```

#### Delete an Item: `DELETE /api/v1/items/:id`
example:  This will not return any data, but you will receive a 204 status to confirm the request processed successfully.

## Relationships

#### All items associated with a merchant: `GET /api/v1/merchants/:id/items`
example: `http://localhost:3000/api/v1/merchants/8/items`
```
{
    "data": [
        {
            "id": "126",
            "type": "item",
            "attributes": {
                "name": "Item Dolore Hic",
                "description": "Veritatis voluptatem suscipit quia est qui. Et ipsam deleniti. Aut est iste facere ad.",
                "unit_price": 147.33,
                "merchant_id": 8
            }
        },
        {
            "id": "127",
            "type": "item",
            "attributes": {
                "name": "Item Ut Illum",
                "description": "Enim quae sit doloremque accusantium eaque amet quasi. Provident modi ipsum. Itaque voluptas quis non. In odio velit.",
                "unit_price": 417.02,
                "merchant_id": 8
            }
        },
```        

#### The merchant associated with an item: `GET /api/v1/items/:id/merchants`
example: `http://localhost:3000/api/v1/items/5/merchants`
```
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```

## Merchant Search

#### Return a single record that matches criteria: `GET /api/v1/merchants/find?<attribute>=<value>`
example: `http://localhost:3000/api/v1/merchants/find?name=terry`
```
{
    "data": {
        "id": "84",
        "type": "merchant",
        "attributes": {
            "name": "Terry-Moore"
        }
    }
}
```

#### Return all records that match criteria: `GET /api/v1/merchants/find_all?<attribute>=<value>`
example: `http://localhost:3000/api/v1/merchants/find_all?name=bern`
```
{
    "data": [
        {
            "id": "7",
            "type": "merchant",
            "attributes": {
                "name": "Bernhard-Johns"
            }
        },
        {
            "id": "36",
            "type": "merchant",
            "attributes": {
                "name": "Bernhard, Stanton and Funk"
            }
        }
    ]
}
```

## Item Search

#### Return a single record that matches criteria: `GET /api/v1/items/find?<attribute>=<value>`
example: `http://localhost:3000/api/v1/items/find?description=totam`
```
{
    "data": {
        "id": "36",
        "type": "item",
        "attributes": {
            "name": "Item Omnis Molestiae",
            "description": "Beatae ratione voluptatem rem cumque voluptas consequatur et. In aliquid rerum aliquam est tempore quas. Consequatur deleniti perspiciatis totam illo enim maxime non. Ea et perspiciatis autem ex et tenetur ullam. Aut nam ut ab nostrum.",
            "unit_price": 93.18,
            "merchant_id": 2
        }
    }
}
```

#### Return all records that match criteria: `GET /api/v1/items/find_all?<attribute>=<value>`
example: `http://localhost:3000/api/v1/items/find_all?description=totam`
```
{
    "data": [
        {
            "id": "36",
            "type": "item",
            "attributes": {
                "name": "Item Omnis Molestiae",
                "description": "Beatae ratione voluptatem rem cumque voluptas consequatur et. In aliquid rerum aliquam est tempore quas. Consequatur deleniti perspiciatis totam illo enim maxime non. Ea et perspiciatis autem ex et tenetur ullam. Aut nam ut ab nostrum.",
                "unit_price": 93.18,
                "merchant_id": 2
            }
        },
        {
            "id": "42",
            "type": "item",
            "attributes": {
                "name": "Item Sapiente Sed",
                "description": "Eum et vel quam reprehenderit soluta quod voluptates. Maxime expedita voluptatibus. Dicta molestias architecto officia sit. Sed tempora et ducimus totam saepe earum eos.",
                "unit_price": 605.58,
                "merchant_id": 2
            }
        },
```        

## Business Intelligence

#### Return variable munber of merchants ranked by total revenue: `GET /api/v1/merchants/most_revenue?quantity=x`
example: `http://localhost:3000/api/v1/merchants/most_revenue?quantity=2`
```
{
    "data": [
        {
            "id": "14",
            "type": "merchant",
            "attributes": {
                "name": "Dicki-Bednar"
            }
        },
        {
            "id": "89",
            "type": "merchant",
            "attributes": {
                "name": "Kassulke, O'Hara and Quitzon"
            }
        }
    ]
}
```

#### Return variable number of merchants ranked by total items sold: `GET /api/v1/merchants/most_items?quantity=x`
example: `http://localhost:3000/api/v1/merchants/most_items?quantity=2`
```
{
    "data": [
        {
            "id": "89",
            "type": "merchant",
            "attributes": {
                "name": "Kassulke, O'Hara and Quitzon"
            }
        },
        {
            "id": "12",
            "type": "merchant",
            "attributes": {
                "name": "Kozey Group"
            }
        }
    ]
}
```

#### Return total revenue across merchants between dates: `GET /api/v1/revenue?start=<start_date>&end=<end_date>`
example: `http://localhost:3000/api/v1/revenue?start=2012-03-09&end=2012-03-24`
```
{
    "data": {
        "id": null,
        "attributes": {
            "revenue": 40945238.33000031
        }
    }
}
```

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
