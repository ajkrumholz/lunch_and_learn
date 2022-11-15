# README

![ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) ![ror](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
## Backend for Lunch and Learn Application

### Intro

This Backend repository should satisfy the requirements of the Frontend development team as outlined [in this document](https://backend.turing.edu/module3/projects/lunch_and_learn/requirements)

A thorough summary of the available endpoints and request syntax, along with response examples, can be found below.

[Recipe Endpoints](#recipe-endpoints)<br>
    * [GET](#get-apiv1recipes)

[Learning Resources Endpoints](#learning-resources-endpoints)<br>
    * [GET](#get-apiv1learning_resources)
    
[Users Endpoints](#users-endpoints)<br>
    * [POST](#post-apiv1users)
    
[Favorites Endpoints](#favorites-endpoints)<br>
    * [GET](#get-apiv1favorites)
    * [POST](#post-apiv1favorites)
    * [DELETE](#delete-apiv1favoritesfavorite_id)
    
[Sessions Endpoints](#sessions-endpoints)<br>
    * [POST](#post-apiv1sessions)

## NOTE: These endpoints have been designed to accept request bodies formatted in application/json. Please make sure to format your requests accordingly.

### Gems, setup instructions, database info
* Ruby version
2.7.4

* System dependencies
    * ```figaro```
    * ```faraday```
    * ```jsonapi-serializer```
    * ```active_model_serializers```
    * ```bcrypt```

* Database creation

Database: ```postgresql```

```
rails db:create
rails db:migrate
```

* How to run the test suite

Testing with ```rspec-rails```

```bundle exec rspec```

## API Endpoints

### Recipe Endpoints

#### ```get /api/v1/recipes```

#### Params
country (optional) - string
If country param is included and a country is specified, returns a list of 10 recipes matching a search of the Edamam API using that string.
If the country param is omitted, a random country is selected and searched as above.

#### Sample request
```get /api/v1/recipes?country=germany```

#### Sample response
```
{
    "data": [
        {
            "id": "null",
            "type": "recipe",
            "attributes": {
                "title": "Cinnamon Stars: Zimtsterne (Germany)",
                "url": "https://www.foodnetwork.com/recipes/food-network-kitchen/cinnamon-stars-zimtsterne-germany-recipe-2009033",
                "image": "https://edamam-product-images.s3.amazonaws.com/web-img/...,
                "country": "germany"
            }
        },....
    ]
}
```

### Learning Resources Endpoints

#### ```get /api/v1/learning_resources```

#### Params
country (required) - string
Returns learning resources relating to specified country, including youtubeId for a relevant video and a collection of images from Flickr

#### Sample request
```get /api/v1/learning_resources?country=germany```

#### Sample response
```
{
    "data": {
        "id": "null",
        "type": "learning_resource",
        "attributes": {
            "id": "null",
            "country": "germany",
            "video": {
                "title": "A Super Quick History of Germany",
                "youtube_video_id": "7sxora2imC0"
            },
            "images": [
                {
                    "alt_tag": "22-11-10 pan sonauf wolk weiss kodens surf fass bok txt ds_06881",
                    "url": "https://live.staticflickr.com/65535/52498921032_cb81b20314_c.jpg"
                },...
            ]
        ]
    }
}
```

### Users Endpoints

#### ```post /api/v1/users```

#### Params (body - application/json)
user:
name (required) - string
email (required) - string

Creates an entry in the users database. Successful creation of the user also assigns a unique API key.

#### Sample Request

```post /api/v1/users, body: { "name": 'Gary Sinise', 'email': 'gary.sinise@twitter.com', 'password': 'big_password', 'password_confirmation':'big_password' }```

note: application/json format required for request body, query Params not accepted

#### Sample Response

```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "name": "Gary Sinise",
            "email": "gary.sinise@twitter.com",
            "api_key": "is7l9cr4vmp6nt0eybgq"
        }
    }
}
```

### Favorites Endpoints

#### ```get /api/v1/favorites```

Returns a response containing information about the api_key owner's favorite recipes

#### Params
user:
api_key (required) - string

#### sample request
```
{ 
    "user":
        {
            "api_key": "8zedxup1br6f2ckq5wv7"
        }
}
```

#### sample response
```
{
    "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "id": 1,
                "recipe_title": "Candy canes",
                "recipe_link": "www.recipe.com/info",
                "country": "germany",
                "created_at": "2022-11-14T17:42:48.989Z"
            }
        }...,
    ]
}
```
#### ```post /api/v1/favorites```

Creates a new entry in the Favorites table associated with the api_key owner. Returns a 201 response on success.

#### Params
favorite:
country (required) - string
recipe_link (required) - string
recipe_title (required) - string

user:
api_key (required) - string

#### sample request
```
{ 
    "favorite": 
        {
            "country": "germany",
            "recipe_link": "www.recipe.com/info",
            "recipe_title": "Candy canes"
        },
    "user":
        {
            "api_key": "8zedxup1br6f2ckq5wv7"
        }
}
```

#### sample response
```
{
    "success": "Favorite added successfully"
}
```
#### ```delete /api/v1/favorites/:favorite_id```

Deletes the relevant record

#### Params

user:
api_key (required) - string

#### sample request

```delete "/api/v1/favorites/3", body: { user: { api_key: asdfkwepfq38293 } }```

Response will be empty, but should have status 204

### Sessions Endpoints

#### ```post /api/v1/sessions```

Allows a user to login once created

#### sample request

```post "/api/v1/sessions/", body: { user: { email: "gary.sinise@twitter.com", password: "bigpassword" } }```

#### sample response

```
{
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "name": "Gary Sinise",
            "email": "gary.sinise@twitter.com",
            "api_key": "8zedxup1br6f2ckq5wv7"
        }
    }
}
```