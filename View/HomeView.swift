//
//  ContentView.swift
//  Currency Converter
//
//  Created by An Luu on 13/12/24.
//

import SwiftUI

/// HomeView containing the main function
struct HomeView: View {
    
    /// User-entered amount to be converted
    @State private var amount: String = ""
    /// Selected currency to convert from
    @State private var fromCurrency: String = "USD"
    /// Selected currency to convert to
    @State private var toCurrency: String = "EUR"
    /// Result of the currency conversion
    @State private var convertedAmount: String = ""
    /// Controls the visibility of the alert
    @State private var showAlert: Bool = false
    /// Message displayed in the alert/
    @State private var alertMessage: String = ""
    /// Current conversion rate between selected currencies
    @State private var conversionRate: String = "0.0"

    /// List of available currencies/
    let currencies = ["USD", "EUR", "GBP", "INR", "JPY"]
    
    /// Instance of the currency service to fetch exchange rates/
    private let currencyService = CurrencyService()

    var body: some View {
        VStack {
            VStack{
                Text("Conversion Rate: \(conversionRate)")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
                
            HStack{
                VStack{
                    HStack{
                        TextField("Enter amount", text: $amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        Picker("From", selection: $fromCurrency) {
                            ForEach(currencies.filter { $0 != toCurrency }, id: \.self) { currency in
                                Text(currency)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: fromCurrency) {
                            fetchExchangeRate()
                        }
                    } // HStack for input amount
                    
                    HStack{
                        TextField("", text: $convertedAmount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .disabled(true)
                        
                        Spacer()
                        
                        Picker("To", selection: $toCurrency) {
                            ForEach(currencies.filter { $0 != fromCurrency }, id: \.self) { currency in
                                Text(currency)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: toCurrency) {
                            fetchExchangeRate()
                        }
                    } // HStack for convert amount
                }
    
                Button(action: {
                    swapCurrencies()
                }) {
                    Image(systemName: "arrow.up.arrow.down")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Button(action: {
                convertCurrency()
            }) {
                Text("Convert")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Image("bgArt")
                .resizable()
                .scaledToFit()
                .padding()
        
            Spacer()
            
        }
        .onAppear {
            fetchExchangeRate() // Fetch exchange rate on initial load
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    /// Function to swap the selected currencies
    private func swapCurrencies() {
        let temp = fromCurrency
        fromCurrency = toCurrency
        toCurrency = temp
        fetchExchangeRate() // Update the exchange rate after swapping
    }
    
    /// Function to ensure valid selections for both pickers
    private func ensureValidSelection() {
        if fromCurrency == toCurrency {
            // Adjust the `fromCurrency` or `toCurrency` to prevent duplication
            if let newFromCurrency = currencies.first(where: { $0 != toCurrency }) {
                fromCurrency = newFromCurrency
            } else if let newToCurrency = currencies.first(where: { $0 != fromCurrency }) {
                toCurrency = newToCurrency
            }
        }
    }
    
    /// Function to fetch the exchange rate without conversion
    private func fetchExchangeRate() {
        currencyService.convertCurrency(amount: 1.0, fromCurrency: fromCurrency, toCurrency: toCurrency) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let (_, rate)):
                    self.conversionRate = String(format: "%.4f", rate) // Update conversion rate
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }

    /// Function to convert currency based on user-entered amount
    private func convertCurrency() {
        guard let amountDouble = Double(amount) else {
            // Show error for invalid input
            alertMessage = "Please enter a valid amount."
            showAlert = true
            return
        }
        
        currencyService.convertCurrency(amount: amountDouble, fromCurrency: fromCurrency, toCurrency: toCurrency) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let (convertedAmount, _)):
                    self.convertedAmount = String(format: "%.2f", convertedAmount) // Update converted amount
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
