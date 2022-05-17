//
//  ContentView.swift
//  Shared
//
//  Created by Tatiana Simmer on 01/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var amountFrom = 0.0
    @State private var currencyTo = "EUR"
    @State private var currencyFrom = "USD"
    @FocusState private var amountIsFocused: Bool
    
    var convertRateDictionary = [
        "EUR": [
            "EUR": 1.0,
            "USD": 1.042,
            "RUB": 68.0,
        ],
        "USD": [
            "EUR": 0.959,
            "USD": 1.0,
            "RUB": 64.62,
        ],
        "RUB": [
            "EUR": 0.014810,
            "USD": 0.01547,
            "RUB": 1.0,
        ]
    ]
    
    var convertedAmount: Double {
        let rate = convertRateDictionary[currencyFrom]![currencyTo]
        let amountTo = amountFrom * rate!
        
        return amountTo
    }
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $amountFrom, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Choose your currency", selection: $currencyFrom) {
                        Text("USD").tag("USD")
                        Text("EUR").tag("EUR")
                        Text("RUB").tag("RUB")
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Enter your amount")
                        .foregroundColor(.black)
                    
                }
                Section {
                    Text(1, format: .currency(code: currencyFrom))
                    +
                    Text(" = ")
                    +
                    Text(convertRateDictionary[currencyFrom]![currencyTo]!, format: .currency(code: currencyTo))
                    Text(1, format: .currency(code: currencyTo))
                    +
                    Text(" = ")
                    +
                    Text(convertRateDictionary[currencyTo]![currencyFrom]!, format: .currency(code: currencyFrom))
                }
                
                Section {
                    Picker("Choose your currency", selection:$currencyTo, content: {
                        Text("USD").tag("USD")
                        Text("EUR").tag("EUR")
                        Text("RUB").tag("RUB")
                    }).pickerStyle(.segmented)
                    Text(convertedAmount, format: .currency(code: currencyTo))
                } header: {
                    Text("Converted amount")
                    .foregroundColor(.black)
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, .mint, .blue,]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("Currency changer")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
