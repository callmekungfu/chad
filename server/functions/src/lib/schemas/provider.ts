export const post = {
  "required": [
    "email",
    "phoneNumber",
    "address",
    "company"
  ],
  "properties": {
    "email": {
      "type": "string"
    },
    "phoneNumber": {
      "type": "string"
    },
    "address": {
      "type": "string",
    },
    "company": {
      "type": "string",
    },
    "description": {
      "type": "string",
    },
    "isLiscened": {
      "type": "boolean",
    },
  }
}

export const put = {
  "properties": {
    "phoneNumber": {
      "type": "string"
    },
    "address": {
      "type": "string",
    },
    "company": {
      "type": "string",
    },
    "description": {
      "type": "string",
    },
    "sunday": {
      "type": "string",
    },
    "monday": {
      "type": "string",
    },
    "tuesday": {
      "type": "string",
    },
    "wednesday": {
      "type": "string",
    },
    "thursday": {
      "type": "string",
    },
    "friday": {
      "type": "string",
    },
    "saturday": {
      "type": "string",
    },
    "isLiscened": {
      "type": "boolean",
    },
  }
}
