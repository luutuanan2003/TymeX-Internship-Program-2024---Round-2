import Foundation

// Define the Product class
class Product {
    let name: String
    let price: Double
    var quantity: Int
    
    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

// Sample inventory
let inventory = [
    Product(name: "Laptop", price: 999.99, quantity: 5),
    Product(name: "Smartphone", price: 499.99, quantity: 10),
    Product(name: "Tablet", price: 299.99, quantity: 0),
    Product(name: "Smartwatch", price: 199.99, quantity: 3)
]

// Function to calculate total inventory value
func calculateTotalInventoryValue(products: [Product]) -> Double {
    return products.reduce(0.0) { total, product in
        total + (product.price * Double(product.quantity))
    }
}

// Function to find the most expensive product
func findMostExpensiveProduct(products: [Product]) -> String? {
    return products.max(by: { $0.price < $1.price })?.name
}

// Function to check if a product exists in inventory
func isProductInStock(products: [Product], productName: String) -> Bool {
    return products.contains(where: { $0.name.lowercased() == productName.lowercased() })
}

// Function to sort products by price or quantity
func sortProducts(products: [Product], by attribute: String, descending: Bool) -> [Product] {
    switch attribute.lowercased() {
    case "price":
        return descending
            ? products.sorted(by: { $0.price > $1.price })
            : products.sorted(by: { $0.price < $1.price })
    case "quantity":
        return descending
            ? products.sorted(by: { $0.quantity > $1.quantity })
            : products.sorted(by: { $0.quantity < $1.quantity })
    default:
        return products
    }
}

// Execute the tasks

// Task 1: Calculate the total inventory value
let totalInventoryValue = calculateTotalInventoryValue(products: inventory)
print("Total Inventory Value: \(String(format: "%.2f", totalInventoryValue))")

// Task 2: Find the most expensive product
if let mostExpensiveProduct = findMostExpensiveProduct(products: inventory) {
    print("Most Expensive Product: \(mostExpensiveProduct)")
}

// Task 3: Check if a product named "Headphones" is in stock
let headphonesInStock = isProductInStock(products: inventory, productName: "Headphones")
print("Headphones exists in inventory: \(headphonesInStock)")

// Task 4: Sort products by price in descending order
let sortedByPriceDescending = sortProducts(products: inventory, by: "price", descending: true)
print("Products sorted by price (descending):")
for product in sortedByPriceDescending {
    print("\(product.name): $\(product.price), quantity: \(product.quantity)")
}

// Task 5: Sort products by quantity in ascending order
let sortedByQuantityAscending = sortProducts(products: inventory, by: "quantity", descending: false)
print("Products sorted by quantity (ascending):")
for product in sortedByQuantityAscending {
    print("\(product.name): $\(product.price), quantity: \(product.quantity)")
}
