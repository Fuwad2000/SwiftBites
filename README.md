# FastAPI Snack Ordering API Documentation

## Overview
This API provides access to a snack ordering menu, allowing users to retrieve a full menu or specific categories of items (snacks, drinks, food).

- **Base URL:** `https://swiftbites.shaikhcloud.com/`
- **Response Format:** JSON

## Endpoints

### Get Full Menu
#### **GET** `/api/menu`
**Description:** Retrieves the full menu including snacks, drinks, and food items.

**Response:**
```json
{
  "data": {
    "snacks": { ... },
    "drinks": { ... },
    "food": { ... }
  }
}
```

---

### Get Drinks Menu
#### **GET** `/api/drinks`
**Description:** Retrieves the list of drinks from the menu.

**Response:**
```json
{
  "data": {
    "drink1": { "id": "drink1", "name": "Coca Cola", "description": "Chilled and refreshing Coca Cola soda.", "price": 2.49, "image": "drink1.jpg" },
    "drink2": { ... }
  }
}
```

---

### Get Snacks Menu
#### **GET** `/api/snacks`
**Description:** Retrieves the list of snacks from the menu.

**Response:**
```json
{
  "data": {
    "snack1": { "id": "snack1", "name": "Cheesy Nachos", "description": "Crispy tortilla chips topped with melted cheese and jalapenos.", "price": 5.99, "image": "snack1.jpg" },
    "snack2": { ... }
  }
}
```

---

### Get Food Menu
#### **GET** `/api/food`
**Description:** Retrieves the list of food items from the menu.

**Response:**
```json
{
  "data": {
    "food1": { "id": "food1", "name": "Cheeseburger", "description": "Juicy beef patty with cheese, lettuce, and tomato.", "price": 8.99, "image": "food1.jpg" },
    "food2": { ... }
  }
}
```

## Error Handling
If an error occurs while reading the `menu.json` file, the API will return:
```json
{
  "data": "Error message here"
}
```

## CORS Policy
The API allows requests from all origins using CORS middleware.

## Usage in Swift (Xcode)
To fetch data from the API in Swift, use `URLSession`:
```swift
let url = URL(string: "https://swiftbites.shaikhcloud.com/api/menu")!
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let data = data {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print(json)
        }
    }
}
task.resume()


