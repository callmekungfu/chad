# CHAD Limited.
[![CircleCI](https://circleci.com/gh/professor-forward/chad/tree/master.svg?style=svg&circle-token=ecfa7070fa171e53e5b6170984631f5a68fb20b0)](https://circleci.com/gh/professor-forward/chad/tree/master)

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

### GET /providers

Response(s)

``` json
{
    "isSuccess": true,
    "provider": [
        {
            "id": "f95MKFquyXPHjCPrqZpR",
            "data": {
                "isLiscened": true,
                "description": "lorem ipsum",
                "address": "test",
                "phoneNumber": "1234567890",
                "company": "test",
                "email": "test"
            }
        },
        {
            "id": "hWKko2UakIIGKr0qj3gl",
            "data": {
                "description": "lorem ipsum",
                "address": "test2",
                "phoneNumber": "1231231230",
                "company": "test2",
                "email": "test2",
                "isLiscened": false
            }
        }
    ]
}
```

### GET /providers/:id

Response(s)

``` json
{
    "isSuccess": true,
    "provider": {
        "id": "xxtV5g1dlVXYmeCc0HaA",
        "data": {
            "description": "lorem ipsum",
            "address": "test2",
            "phoneNumber": "1231231230",
            "company": "test2",
            "email": "wangyonglin1999@gmail.com",
            "isLiscened": true
        },
        "services": [
            {
                "id": "57VLDH0UcyQrhYBpCSmc",
                "data": {
                    "name": "Yonglin Wang",
                    "price": 0.01,
                    "role": "Hackerman"
                }
            },
            {
                "id": "BQsRB0RpMoA9qEWDSwCz",
                "data": {
                    "price": 65767,
                    "role": "yonglin",
                    "name": "THAI MASSAGE"
                }
            }
        ]
    }
}
```

``` json
204 NOT FOUND
```

### POST /providers

Body

``` json
{
    "email": "test2",
    "phoneNumber": "1231231230",
    "address": "test2",
    "company": "test2",
    "description": "lorem ipsum",
    "isLiscened": false
}
```

Response(s)

``` json
{
    "isSuccess": true,
    "provider": {
        "id": "hWKko2UakIIGKr0qj3gl",
        "data": {
            "isLiscened": false,
            "description": "lorem ipsum",
            "address": "test2",
            "phoneNumber": "1231231230",
            "company": "test2",
            "email": "test2"
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

### DELETE /providers/:id

Response(s)

``` json
204 NOT FOUND
```

### PUT /providers/:id

Body

``` json
{
    "email": "test2", // optional
    "phoneNumber": "1231231230", // optional
    "address": "test2", // opotional
    "company": "test2", // optional
    "description": "lorem ipsum", // optional
    "isLiscened": false // optional
}
```

Response(s)

``` json
{
    "isSuccess": true,
    "provider": {
        "id": "hWKko2UakIIGKr0qj3gl",
        "service": {
            "phoneNumber": "1231231230" // return modified fields
        }
    }
}
```

``` json
204 NOT FOUND
```

### DELETE /providers/:providerId

Response(s)

204 NOT FOUND

### POST /providers/:providerId/dates/:date

Body

``` json
{
    "serviceId": "57VLDH0UcyQrhYBpCSmc",
    "userId": "test",
    "time" : "9:00"
}

```

Response(s)

``` json
{
    "isSuccess": true,
    "appointment": {
        "id": "Ry4jRIRtR81gLzcl0iNF",
        "data": {
            "time": "9:00",
            "serviceId": "57VLDH0UcyQrhYBpCSmc",
            "userId": "test"
        }
    }
}

```

### GET /providers/f3ASWnDDNkjFwpsVBRRh/dates/24-11-2019

Response(s)

``` json
{
    "isSuccess": true,
    "appointment": [
        {
            "id": "6Nzo8vbcaSTBtIacIFi5",
            "data": {
                "serviceId": "Lue07Yh2mFbQUvufXaye",
                "userId": "test@test.ca",
                "time": "9:00"
            }
        },
        {
            "id": "CYJfWNWHaqAeq3Tw84F3",
            "data": {
                "serviceId": "Lue07Yh2mFbQUvufXaye",
                "userId": "test@test.ca",
                "time": "9:30"
            }
        },
        {
            "id": "DZjj9g8ERZH9A1H8cE0j",
            "data": {
                "serviceId": "Lue07Yh2mFbQUvufXaye",
                "userId": "test@test.ca",
                "time": "9:15"
            }
        }
    ]
}

```

### GET /providers/f3ASWnDDNkjFwpsVBRRh/dates/24-11-2019?time=9:15

Response(s)

``` json
{
    "isSuccess": true,
    "appointment": [
        {
            "id": "CYJfWNWHaqAeq3Tw84F3",
            "data": {
                "serviceId": "Lue07Yh2mFbQUvufXaye",
                "userId": "test@test.ca",
                "time": "9:30"
            }
        },
        {
            "id": "DZjj9g8ERZH9A1H8cE0j",
            "data": {
                "serviceId": "Lue07Yh2mFbQUvufXaye",
                "userId": "test@test.ca",
                "time": "9:15"
            }
        }
    ]
}

```
