//
//  ContentView.swift
//  converter
//
//  Created by Kuzey Köse on 5/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Weight()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Weight")
                }
        }
    }
}

struct Weight: View {
    @State private var weight: Double = 0
    @State private var selectedView = "Pounds"
    @State private var weightSelection: [String: Bool]

    let viewOptions = ["Pounds", "Kilos"]
    private let kilosData: [String: Bool] = [
        "25": true, "20": true, "15": true, "10": true, "5": true, "2.5": true, "1": true, "0.75": true, "0.5": true,
    ]
    private let poundData: [String: Bool] = [
        "55": true, "45": true, "35": true, "25": true, "15": true, "10": true,
        "5": true, "2.5": true, "1.25": true,
    ]

    init() {
        _weightSelection = State(initialValue: poundData)
    }

    var body: some View {
        VStack {
            Picker("Select View", selection: $selectedView) {
                ForEach(viewOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedView) {
                handleViewChange(selectedView)
            }

            PlateSelection(weightSelection: $weightSelection)

            if selectedView == "Pounds" {
                Pounds(weightSelection: weightSelection)
            } else if selectedView == "Kilos" {
                Kilos(weightSelection: weightSelection)
            }

            Spacer()
        }
    }

    private func handleViewChange(_ newValue: String) {
        if newValue == "Kilos" {
            weightSelection = kilosData
        } else if newValue == "Pounds" {
            weightSelection = poundData
        }
    }

    struct PlateSelection: View {
        @Binding var weightSelection: [String: Bool]

        var body: some View {
            HStack(spacing: 6) {
                ForEach(
                    weightSelection.keys.sorted(by: {
                        Double($0) ?? 0 > Double($1) ?? 0
                    }), id: \.self
                ) { weight in
                    Button(action: {
                        weightSelection[weight]?.toggle()
                    }) {
                        Text(weight)
                            .frame(width: 35, height: 40)
                            .background(
                                weightSelection[weight] == true
                                    ? Color.green : Color.gray
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    struct Pounds: View {
        @State private var totalWeight: String = ""
        @State private var plates = [(weight: Double, count: Int)]()
        @State private var selectedBarType: String = "Long Bar (44lb)"
        let weightSelection: [String: Bool]

        let barWeights = ["Short Bar (35lb)": 35, "Long Bar (45lb)": 45]
        let poundPlates = [55, 45, 35, 25, 10, 5]

        let colorMap: [Double: Color] = [
            55: .red, 45: .blue, 35: .yellow, 25: .green, 10: .gray, 5: .gray,
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
                    plates = Weight.calculatePlates(barWeights:barWeights, selectedBarType: selectedBarType, totalWeight: totalWeight, plateSizes: weightSelection)
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
                            .overlay(
                                Text(String(format: "%.1f", plate.weight))
                                    .foregroundColor(.white))
                        Text("x\(plate.count)")
                            .padding(.leading, 10)
                    }
                }
            }
            .padding()

        }

        func colorForPlate(_ weight: Double) -> Color {
            return colorMap[weight] ?? .gray
        }
    }
    
    static func calculatePlates(barWeights: [String: Int], selectedBarType: String, totalWeight: String, plateSizes: [String: Bool]) -> [(Double, Int)] {
        guard let weight = Double(totalWeight),
              let barWeight = barWeights[selectedBarType],
              weight > Double(barWeight) else {
            return []
        }

        let netWeight = weight - Double(barWeight)
        var remainingWeight = netWeight
        var results = [(Double, Int)]()

        let selectedWeights: [Double] = plateSizes.compactMap {
            key, value in
            value ? Double(key) : nil
        }

        for plate in selectedWeights.sorted(by: >) {
            let count = Int(remainingWeight / plate)
            let evenCount = (count % 2 == 0) ? count : count - 1
            if evenCount > 0 {
                results.append((plate, evenCount))
                remainingWeight -= Double(evenCount) * plate
            }
        }

        return results
    }

    struct Kilos: View {
        @State private var totalWeight: String = ""
        @State private var plates = [(weight: Double, count: Int)]()
        @State private var selectedBarType: String = "Long Bar (20kg)"
        let weightSelection: [String: Bool]
        let barWeights = ["Short Bar (15kg)": 15, "Long Bar (20kg)": 20]

        let colorMap: [Double: Color] = [
            25: .blue,
            20: .red,
            15: .green,
            10: .yellow,
            2.5: .purple,
            1.25: .orange,
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
                    plates = Weight.calculatePlates(barWeights:barWeights, selectedBarType: selectedBarType, totalWeight: totalWeight, plateSizes: weightSelection)
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
                            .overlay(
                                Text(String(format: "%.1f", plate.weight))
                                    .foregroundColor(.white))
                        Text("x\(plate.count)")
                            .padding(.leading, 10)
                    }
                }
            }
            .padding()
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
