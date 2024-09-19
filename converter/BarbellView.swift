//
//  BarbellView.swift
//  converter
//
//  Created by Kuzey Köse on 5/10/24.
//

import SwiftUI

struct BarbellView: View {
    @State private var numberInput: String = ""
    
    var body: some View {
        VStack {
            Text("Barbell")
            // Number input field
            TextField("Enter a number", text: $numberInput)
                .keyboardType(.numberPad)
                .padding()
                .border(Color.gray, width: 1)
            
            // Display the entered number
            if let number = Double(numberInput) {
                let result = number * 0.45
                Text("kg:\(number.formatted()) lb:\(result.formatted())")
            } else {
                Text("Please enter a valid number")
            }
        }
        .padding()
        
        ZStack {
            Circle() // Draws a circle
                .fill(Color.black) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("0.25kg")
                .font(.custom("test", size: 12))
                .foregroundColor(Color.white)
        }

        ZStack {
            Circle() // Draws a circle
                .fill(Color.black) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("1.25kg")
                .font(.custom("test", size: 12))
                .foregroundColor(Color.white)
        }
        
        ZStack {
            Circle() // Draws a circle
                .fill(Color.black) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("2.5kg")
                .font(.custom("test", size: 12))
                .foregroundColor(Color.white)
        }

        ZStack {
            Circle() // Draws a circle
                .fill(Color.black) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("5kg")
                .font(.custom("test", size: 12))
                .foregroundColor(Color.white)
        }
        
        ZStack {
            Circle() // Draws a circle
                .fill(Color.green) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("10kg")
                .font(.custom("test", size: 12))
        }
        
        ZStack {
            Circle() // Draws a circle
                .fill(Color.yellow) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("15kg")
                .font(.custom("test", size: 12))
        }
        
        ZStack {
            Circle() // Draws a circle
                .fill(Color.blue) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("20kg")
                .font(.custom("test", size: 12))
        }
        
        ZStack {
            Circle() // Draws a circle
                .fill(Color.red) // Fills the circle with blue color
                .frame(width: 40, height: 40) // Sets the size of the circle
            Text("25kg")
                .font(.custom("test", size: 12))
        }
    }
    
    
}

#Preview {
    BarbellView()
}
