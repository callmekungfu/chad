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
