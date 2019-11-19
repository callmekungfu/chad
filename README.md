# CHAD Limited.

## Team Members

| Name | Student Number |
| --- | --- |
| Yong Lin Wang | 300065862 |
| Braden Collingwood | 300059397 |
| Daniel Wu | 300015800 |
| Anurag Taak | 300073742 |

## API Consumption

``` javascript
    BASE URI = 'https://us-central1-this-is-a-firebase-project.cloudfunctions.net/api/v1';
```

### POST /login

Body

``` json
{
    "password": "asdfasdf",
    "userName": "test@test.acoom"
}
```

Response(s)

``` json
{
    "isSuccess": true,
    "user": {
        "userName": "test@test.acoom",
        "firstName": "testtt",
        "lastName": "testtt",
        "role": "patient"
    }
}
```

``` json
{
    "isSuccess": false,
    "msg": "invalid credentials"
}
```

``` json
204 NOT FOUND
```

### POST /user

Body

``` json
{
    "firstName": "testtt",
    "lastName": "testtt",
    "password": "asdfasdf",
    "userName": "test@test.coom",
    "role": "patient"
}
```

Response(s)

``` json
{
    "isSuccess": false,
    "msg": "user already exists"
}
```

``` json
{
    "isSuccess": true,
    "user": {
        "userName": "test@test.acoom",
        "firstName": "testtt",
        "lastName": "testtt",
        "role": "patient"
    }
}
```

### GET /services

Response(s)

``` json
{
    "isSuccess": true,
    "service": [
        {
            "id": "57VLDH0UcyQrhYBpCSmc",
            "data": {
                "name": "Yonglin Wang",
                "price": 0.01,
                "role": "Hackerman"
            }
        },
        {
            "id": "B1HSf36f8coI90PlD3Cw",
            "data": {
                "name": "Daniel Wu",
                "price": 9.99,
                "role": "Hackerman"
            }
        },
        {
            "id": "Hb8rU0lAcmodqNXiceyx",
            "data": {
                "name": "Yonglin Wang",
                "price": 1,
                "role": "Hackerman"
            }
        }
    ]
}
```

### GET /services/:id

Response(s)

``` json
{
    "isSuccess": true,
    "service": {
        "id": "57VLDH0UcyQrhYBpCSmc",
        "data": {
            "price": 0.01,
            "role": "Hackerman",
            "name": "Yonglin Wang"
        }
    }
}
```

``` json
204 NOT FOUND
```

### POST /services

Body

``` json
{
    "name": "Yonglin Wang",
    "role": "Hackerman",
    "price": 19.99
}
```

Response(s)

``` json
{
    "isSuccess": true,
    "service": {
        "id": "NuXdEGsqHnxmko2TJk6k",
        "data": {
            "role": "Hackerman",
            "name": "Yonglin Wang",
            "price": 19.99
        }
    }
}
```

``` json
{
    "isSuccess": false,
    "msg": "invalid body"
}
```

### DELETE /services/:id

Response(s)

``` json
204 NOT FOUND
```

### PUT /services/:id

Body

``` json
{
    "name": "Yonglin Wang", //optional
    "role": "Hackerman", //optional
    "price": 21.99 //optional
}
```

Response(s)

``` json
{
    "isSuccess": true,
    "service": {
        "id": "Hb8rU0lAcmodqNXiceyx",
        "service": {
            "price": 21.99 // return modified fields
        }
    }
}
```

``` json
204 NOT FOUND
```
