//
//  ContentView.swift
//  converter
//
//  Created by Kuzey Köse on 5/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        TabView {
            Weight()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Weight")
                }
            
            Text("Miles to KMs")
                .tabItem {
                    Image(systemName: "road.lanes")
                    Text("Distance")
                }
        }
    }
}

struct Weight: View {
    @State private var selectedView = ""
    let viewOptions = ["Pounds", "Kilos"]
    
    var body: some View {
        VStack{
            Picker("Select View", selection: $selectedView) {
                ForEach(viewOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedView == "Pounds" {
                Pounds()
            } else if selectedView == "Kilos" {
                Kilos()
            }
            
        }
    }
    
    
    struct Pounds: View {
        @State private var totalWeight: String = ""
        @State private var plates = [(weight: Double, count: Int)]()
        @State private var selectedBarType: String = "Long Bar (44lb)"
        
        let barWeights = ["Short Bar (35lb)": 35, "Long Bar (45lb)": 45]
        let poundPlates = [55, 45, 35, 25, 10, 5]
        
        let colorMap: [Double: Color] = [
            55: .red, 45: .blue, 35: .yellow, 25: .green, 10: .gray, 5: .gray
        ]
        
        var body: some View {
            VStack(spacing: 20) {
                TextField("Enter total weight in pounds", text: $totalWeight)
                    .keyboardType(.decimalPad)
                    .padding()
                    .border(Color.gray, width: 1)
                
                Picker("Select Bar Type", selection: $selectedBarType) {
                    ForEach(barWeights.keys.sorted(), id: \.self) { key in
                        Text(key).tag(key)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Calculate Plates") {
                    calculatePlates()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                ForEach(plates, id: \.weight) { plate in
                    HStack {
                        Circle()
                            .fill(colorForPlate(plate.weight))
                            .frame(width: 50, height: 50)
                            .overlay(Text(String(format: "%.1f", plate.weight))
                                .foregroundColor(.white))
                        Text("x\(plate.count)")
                            .padding(.leading, 10)
                    }
                }
            }
            .padding()
        }
        
        func calculatePlates() {
            guard let weight = Double(totalWeight), let barWeight = barWeights[selectedBarType], weight > Double(barWeight) else {
                plates = []
                return
            }
            let netWeight = weight - Double(barWeight)
            let plateSizes: [Double] = [55, 45, 35, 25, 10, 5]
            var remainingWeight = netWeight
            var results = [(Double, Int)]()
            
            for plate in plateSizes {
                let count = Int(remainingWeight / plate)
                let evenCount = (count % 2 == 0) ? count : count - 1
                if evenCount > 0 {
                    results.append((plate, evenCount))
                    remainingWeight -= Double(evenCount) * plate
                }
            }
            
            plates = results
        }
        
        // Retrieve the color for each plate based on its weight
        func colorForPlate(_ weight: Double) -> Color {
            return colorMap[weight] ?? .gray  // Default to gray if no specific color is found
        }
    }
    
    struct Kilos: View {
        @State private var totalWeight: String = ""
        @State private var plates = [(weight: Double, count: Int)]()
        @State private var selectedBarType: String = "Long Bar (20kg)"
        
        let barWeights = ["Short Bar (15kg)": 15, "Long Bar (20kg)": 20]
        
        let colorMap: [Double: Color] = [
            25: .blue,
            20: .red,
            15: .green,
            10: .yellow,
            2.5: .purple,
            1.25: .orange
        ]
        
        var body: some View {
            VStack(spacing: 20) {
                TextField("Enter total weight", text: $totalWeight)
                    .keyboardType(.decimalPad)
                    .padding()
                    .border(Color.gray, width: 1)
                
                Picker("Select Bar Type", selection: $selectedBarType) {
                    ForEach(barWeights.keys.sorted(), id: \.self) { key in
                        Text(key).tag(key)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Calculate Plates") {
                    calculatePlates()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                ForEach(plates, id: \.weight) { plate in
                    HStack {
                        Circle()
                            .fill(colorForPlate(plate.weight))
                            .frame(width: 50, height: 50)
                            .overlay(Text(String(format: "%.1f", plate.weight))
                                .foregroundColor(.white))
                        Text("x\(plate.count)")
                            .padding(.leading, 10)
                    }
                }
            }
            .padding()
        }
        
        func calculatePlates() {
            guard let weight = Double(totalWeight), let barWeight = barWeights[selectedBarType], weight > Double(barWeight) else {
                plates = []
                return
            }
            let netWeight = weight - Double(barWeight)
            let plateSizes: [Double] = [25, 20, 15, 10, 2.5, 1.25]
            var remainingWeight = netWeight
            var results = [(Double, Int)]()
            
            for plate in plateSizes {
                let count = Int(remainingWeight / plate)
                let evenCount = (count % 2 == 0) ? count : count - 1
                if evenCount > 0 {
                    results.append((plate, evenCount))
                    remainingWeight -= Double(evenCount) * plate
                }
            }
            
            plates = results
        }
        
        // Retrieve the color for each plate based on its weight
        func colorForPlate(_ weight: Double) -> Color {
            return colorMap[weight] ?? .gray  // Default to gray if no specific color is found
        }
    }
}

#Preview {
    ContentView()
}
