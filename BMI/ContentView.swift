//  ContentView.swift
//  BMI
//
//  Created by Sayaka Sasaki on 2025/11/02.
//

import SwiftUI

struct ContentView: View {
    @State private var heightValue: Double?
    @State private var weightValue: Double?
    @State private var originalUnit = "cm"
    @FocusState private var isFocused: Bool
    
    
    let lengthUnits = ["m", "cm"]
    
    // BMIを自動計算するプロパティ
      var calculatedBMI: Double? {
          guard let h = heightValue, let w = weightValue else { return nil }
          
          // 入力単位をメートルに変換
          let heightInMeters: Double
          switch originalUnit {
          case "cm":
              heightInMeters = h / 100
          default:
              heightInMeters = h
          }
          
          guard heightInMeters > 0 else { return nil }
          
          return w / (heightInMeters * heightInMeters)
      }
      
      // BMIの判定文
      var bmiCategory: String {
          guard let bmi = calculatedBMI else { return " " }
          switch bmi {
          case ..<18.5:
              return "低体重"
          case 18.5..<25:
              return "普通体重"
          case 25..<30:
              return "肥満（1度）"
          case 30..<35:
              return "肥満（2度）"
          case 35..<40:
              return "肥満（3度）"
          default:
              return "肥満（4度）"
          }
      }
    
    var body: some View {
        NavigationView {
            Form{
                
                Section("入力") {
                    //身長の入力欄(textFieldとpicker)
                    HStack {
                        TextField("身長", value: $heightValue, format: .number)
                            .keyboardType(.decimalPad)
                            .font(.title3)
                            .padding()
                            .focused($isFocused)
                            
                        
                        Picker("", selection: $originalUnit) {
                            ForEach(lengthUnits, id: \.self) { unit in
                                Text(unit)
                                    .font(.title3)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 80)
                    }
                    
                    //体重の入力欄（textFieldとtext）
                    HStack {
                        TextField("体重", value: $weightValue, format: .number)
                            .keyboardType(.decimalPad)
                            .font(.title3)
                            .padding()
                            .focused($isFocused)
                        
                        Text("kg")
                            .font(.title3)
                            .foregroundStyle(.gray)
                        
                    }
                    .frame(height: 80)
                }
               
                
                //BMI(text)
                Section("結果") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("あなたのBMI")
                            .font(.title2)
                            .bold()
                        
                        if let bmi = calculatedBMI {
                            Text(String(format: "%.2f", bmi))
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.primary)
                        } else {
                            Text("　")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.gray)
                        }
                        
                        Text("評価: \(bmiCategory)")
                            .font(.title2)
                            .bold()
                    }
                    .padding()
                }
                
            }
            .navigationTitle("BMI計算機")
            
            //キーボードを閉じる
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack{
                        Spacer()
                        Button {
                            isFocused = false
                        } label: {
                            Text("Done")
                        }
                    }
                }
            }
            
        }
    }
}
    
    #Preview {
        ContentView()
    }
