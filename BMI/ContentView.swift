//  ContentView.swift
//  BMI
//
//  Created by Sayaka Sasaki on 2025/11/02.
//

import SwiftUI

struct ContentView: View {
    @State private var enteredNumber: Double = 0.0
    @State private var originalUnit = "meters"
    
    
    let lengthUnits = ["meter", "centimeters"]
    
    var body: some View {
        Form{
            //身長の入力欄
            Section("入力") {
                HStack {
                    TextField("Original", value: $enteredNumber, format: .number)
                        .keyboardType(.numberPad)
                        .padding()
                    
                    Picker("", selection: $originalUnit) {
                        ForEach(lengthUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                
                //体重の入力欄（textField）
                HStack {
                    TextField("Original", value: $enteredNumber, format: .number)
                        .keyboardType(.numberPad)
                        .padding()
                    
                    Text("kg")
                    
                }
            }
            //BMI(text)
            Section("結果"){
                Text("Text 1")
                
                
            }
        }
        
    }
}
    
    
    
    #Preview {
        ContentView()
    }
