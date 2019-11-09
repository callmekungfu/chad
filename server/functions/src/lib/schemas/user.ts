export const post = {
  "required": [
    "userName",
    "password",
    "firstName",
    "lastName",
    "role"
  ],
  "properties": {
    "userName": {
      "type": "string"
    },
    "password": {
      "type": "string"
    },
    "firstName": {
      "type": "string"
    },
    "lastName": {
      "type": "string"
    },
    "role": {
      "type": "string",
      "enum": ["patient", "administrator", "employee"]
    }
  }
}
