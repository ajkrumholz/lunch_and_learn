# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.7.4

* System dependencies
Figaro, Faraday, JSONAPI-Serializer

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## API Endpoints

### Recipe Endpoints

#### get /api/v1/recipes

##### params
country (optional) - string
If country param is included and a country is specified, returns a list of 10 recipes matching a search of the Edamam API using that string.
If the country param is omitted, a random country is selected and searched as above.

##### Sample request
get /api/v1/recipes?country=germany

##### Sample response
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

#### get /api/v1/learning_resources

##### params
country (required) - string
Returns learning resources relating to specified country, including youtubeId for a relevant video and a collection of images from Flickr

##### Sample request
get /api/v1/learning_resources?country=germany

##### Sample response
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

#### post /api/v1/users

##### params (body - application/json)
user.name (required) - string
user.email (required) - string

Creates an entry in the users database. Successful creation of the user also assigns a unique API key.

##### Sample Request

post /api/v1/users, body: { "name": 'Carrie', 'email': 'carrie.wallace@gmail.com' }

note: application/json format required for request body, query params not accepted

##### Sample Response

```
{
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "name": "Carrie",
            "email": "carrie.wallace@gmail.com",
            "api_key": "8zedxup1br6f2ckq5wv7"
        }
    }
}
```

### Favorites Endpoints

#### get /api/v1/favorites

Returns a response containing information about the api_key owner's favorite recipes

##### params
user:
api_key (required) - string

##### sample request
{ 
    "user":
        {
            "api_key": "8zedxup1br6f2ckq5wv7"
        }
}

##### sample response
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

#### post /api/v1/favorites

Creates a new entry in the Favorites table associated with the api_key owner. Returns a 201 response on success.

##### params
favorite:
country (required) - string
recipe_link (required) - string
recipe_title (required) - string

user:
api_key (required) - string

##### sample request
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

##### sample response
{
    "success": "Favorite added successfully"
}


