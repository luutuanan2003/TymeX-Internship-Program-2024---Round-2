import Foundation

// Function to find the missing number
func findMissingNumber(from array: [Int], n: Int) -> Int {
    // Calculate the expected sum of numbers from 1 to n+1
    let expectedSum = (n + 1) * (n + 2) / 2
    
    // Calculate the actual sum of numbers in the array
    let actualSum = array.reduce(0, +)
    
    // The missing number is the difference
    return expectedSum - actualSum
}

// Example usage
let inputArray = [3, 7, 1, 2, 6, 4] // n = 6
let n = 6

let missingNumber = findMissingNumber(from: inputArray, n: n)
print("The missing number is: \(missingNumber)")
