//
//  ContentView.swift
//  BasicCalculator
//
//  Created by Mirzhan Gumarov on 17.09.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            buildNumberPad()
        }
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
    
    @ViewBuilder
    private func buildNumberPad() -> some View {
        VStack {
            HStack {
                buildNumberButton(imageName: "delete.left", fillColor: .calcLightGray)
                buildNumberButton(text: "AC", fillColor: .calcLightGray)
                buildNumberButton(imageName: "percent", fillColor: .calcLightGray)
                buildNumberButton(imageName: "divide", fillColor: .calcOrange)
            }
            
            HStack {
                buildNumberButton(text: "7", fillColor: .calcDarkGray)
                buildNumberButton(text: "8", fillColor: .calcDarkGray)
                buildNumberButton(text: "9", fillColor: .calcDarkGray)
                buildNumberButton(imageName: "multiply", fillColor: .calcOrange)
            }
            
            HStack {
                buildNumberButton(text: "4", fillColor: .calcDarkGray)
                buildNumberButton(text: "5", fillColor: .calcDarkGray)
                buildNumberButton(text: "6", fillColor: .calcDarkGray)
                buildNumberButton(imageName: "minus", fillColor: .calcOrange)
            }
            
            HStack {
                buildNumberButton(text: "1", fillColor: .calcDarkGray)
                buildNumberButton(text: "2", fillColor: .calcDarkGray)
                buildNumberButton(text: "3", fillColor: .calcDarkGray)
                buildNumberButton(imageName: "plus", fillColor: .calcOrange)
            }
            
            HStack {
                buildNumberButton(imageName: "plus.forwardslash.minus", fillColor: .calcDarkGray)
                buildNumberButton(text: "0", fillColor: .calcDarkGray)
                buildNumberButton(text: ",", fillColor: .calcDarkGray)
                buildNumberButton(imageName: "equal", fillColor: .calcOrange)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func buildNumberButton(text: String, fillColor: Color) -> some View {
        Button {
            print("Something")
        } label: {
            ZStack {
                Circle()
                    .fill(fillColor)
                Text(text)
                    .foregroundStyle(Color.white)
                    .font(.largeTitle)
            }
        }
    }
    
    @ViewBuilder
    private func buildNumberButton(imageName: String, fillColor: Color) -> some View {
        Button {
            print("Something")
        } label: {
            ZStack {
                Circle()
                    .fill(fillColor)
                Image(systemName: imageName)
                    .foregroundStyle(Color.white)
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}


extension Color {
    static let calcDarkGray = Color(hex: "#333333")
    static let calcOrange = Color(hex: "#FF9500")
    static let calcLightGray = Color(hex: "#505050")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
