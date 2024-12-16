//
//  CurrencyService.swift
//  Currency Converter
//
//  Created by An Luu on 15/12/24.
//

import Foundation

/// The CurrencyService class handles retrieving the API key, making network requests to fetch live exchange rates, and performing currency conversion calculations.
class CurrencyService {
    
    /// Function to retrieve the API key from the plist file
    func getAPIKey() -> String? {
        // Locate the plist file
        if let path = Bundle.main.path(forResource: "API", ofType: "plist") {
            // Load the plist file into a dictionary
            if let keysDict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                return keysDict["API_KEY"] as? String
            } else {
                print("Failed to parse plist file into a dictionary.")
            }
        } else {
            print("API plist file not found.")
        }
        return nil
    }
    
    /// Fetches the exchange rate and performs the currency conversion.
    func convertCurrency(amount: Double, fromCurrency: String, toCurrency: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        
        // Retrieve the API key from the plist file
        let apiKey = getAPIKey() ?? "No API Key Found"
        
        // Construct the API URL to fetch the latest exchange rates for the source currency
        let url = "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(fromCurrency)"
        
        // Ensure the URL is valid
        guard let requestURL = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        // Start a network request to fetch exchange rates
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 400, userInfo: nil)))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let result = json["result"] as? String, result == "success",
                   let rates = json["conversion_rates"] as? [String: Double],
                   let rate = rates[toCurrency] {
                    let convertedAmount = amount * rate
                    completion(.success((convertedAmount, rate)))
                } else {
                    completion(.failure(NSError(domain: "Invalid API response", code: 500, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
