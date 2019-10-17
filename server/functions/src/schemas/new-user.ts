export default {
  "definitions": {},
  "$schema": "http://json-schema.org/draft-07/schema#",
  "$id": "http://example.com/root.json",
  "type": "object",
  "title": "The Root Schema",
  "required": [
    "email",
    "password",
    "first_name",
    "last_name",
    "role"
  ],
  "properties": {
    "email": {
      "$id": "#/properties/email",
      "type": "string",
      "title": "The Email Schema",
      "default": "",
      "examples": [
        "some@random.email"
      ],
      "pattern": "^(.*)$"
    },
    "password": {
      "$id": "#/properties/password",
      "type": "string",
      "title": "The Password Schema",
      "default": "",
      "examples": [
        "s0m3_s#crEt_pa33w0rd"
      ],
      "pattern": "^(.*)$"
    },
    "first_name": {
      "$id": "#/properties/first_name",
      "type": "string",
      "title": "The First_name Schema",
      "default": "",
      "examples": [
        "First"
      ],
      "pattern": "^(.*)$"
    },
    "last_name": {
      "$id": "#/properties/last_name",
      "type": "string",
      "title": "The Last_name Schema",
      "default": "",
      "examples": [
        "Last"
      ],
      "pattern": "^(.*)$"
    },
    "role": {
      "$id": "#/properties/role",
      "type": "string",
      "title": "The Role Schema",
      "default": "",
      "examples": [
        "admin"
      ],
      "pattern": "^(.*)$"
    }
  }
}