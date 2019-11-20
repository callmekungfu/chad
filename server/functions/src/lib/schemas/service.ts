export const post = {
  "required": [
    "role",
    "name",
    "price"
  ],
  "properties": {
    "role": {
      "type": "string"
    },
    "name": {
      "type": "string"
    },
    "price": {
      "type": "number",
      "minimum": 0.00
    }
  }
}

export const put = {
  "properties": {
    "role": {
      "type": "string"
    },
    "name": {
      "type": "string"
    },
    "price": {
      "type": "number",
      "minimum": 0.00
    }
  }
}
