//
//  ContentView.swift
//  BasicCalculator
//
//  Created by Mirzhan Gumarov on 17.09.2025.
//

import SwiftUI

enum ButtonType {
    case number(Int)
    case function(Function)
    
    enum Function {
        case add, subtract, multiply, divide, percent, changeSign, floatingPoint, clear, remove, result
        
        var display: Display {
            switch self {
            case .add:
                return .systemImage("plus")
            case .subtract:
                return .systemImage("minus")
            case .multiply:
                return .systemImage("multiply")
            case .divide:
                return .systemImage("divide")
            case .percent:
                return .systemImage("percent")
            case .changeSign:
                return .systemImage("plus.forwardslash.minus")
            case .floatingPoint:
                return .text(",")
            case .clear:
                return .text("AC")
            case .remove:
                return .systemImage("delete.left")
            case .result:
                return .systemImage("equal")
            }
        }
        
        var bgColor: Color {
            switch self {
            case .add, .subtract, .multiply, .divide, .result:
                return .calcOrange
            case .percent, .remove, .clear:
                return .calcLightGray
            case .changeSign, .floatingPoint:
                return .calcDarkGray
            }
        }
    }
    
    var display: Display {
        switch self {
        case .number(let number):
            return .text(String(number))
        case .function(let function):
            return function.display
        }
    }
    
    var bgColor: Color {
        switch self {
        case .number:
            return .calcDarkGray
        case .function(let function):
            return function.bgColor
        }
    }
    
    enum Display {
        case text(String)
        case systemImage(String)
    }
}

struct ContentView: View {
    @State var upperText: String = "5 + 4"
    @State var lowerText: String = "9"
    
    var body: some View {
        VStack {
            buildHeader()
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(1)
            buildTextDisplayArea()
                .frame(maxHeight: .infinity)
            buildNumberPad()
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(1)
        }
        .frame(maxHeight: .infinity)
        .background(Color.black)
    }
    
    @ViewBuilder
    private func buildHeader() -> some View {
        HStack {
            Button {
                print("Menu tapped")
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 36, height: 36)
                    Image(systemName: "list.bullet")
                        .foregroundStyle(Color.white)
                        .frame(width: 32, height: 32)
                }
            }
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private func buildTextDisplayArea() -> some View {
        VStack {
            Spacer()
            Text(upperText)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundStyle(Color.gray)
                .font(Font.system(size: 24, weight: .semibold))
            
            Text(lowerText)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundStyle(Color.white)
                .font(Font.system(size: 48, weight: .semibold))
        }
        .padding()
    }
    
    @ViewBuilder
    private func buildNumberPad() -> some View {
        VStack {
            HStack {
                buildNumberButton(type: .function(.remove))
                buildNumberButton(type: .function(.clear))
                buildNumberButton(type: .function(.percent))
                buildNumberButton(type: .function(.divide))
            }
            
            HStack {
                buildNumberButton(type: .number(7))
                buildNumberButton(type: .number(8))
                buildNumberButton(type: .number(9))
                buildNumberButton(type: .function(.multiply))
            }
            
            HStack {
                buildNumberButton(type: .number(4))
                buildNumberButton(type: .number(5))
                buildNumberButton(type: .number(6))
                buildNumberButton(type: .function(.subtract))
            }
            
            HStack {
                buildNumberButton(type: .number(1))
                buildNumberButton(type: .number(2))
                buildNumberButton(type: .number(3))
                buildNumberButton(type: .function(.add))
            }
            
            HStack {
                buildNumberButton(type: .function(.changeSign))
                buildNumberButton(type: .number(0))
                buildNumberButton(type: .function(.floatingPoint))
                buildNumberButton(type: .function(.result))
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func buildNumberButton(type: ButtonType) -> some View {
        Button {
            print("Something")
        } label: {
            ZStack {
                Circle()
                    .fill(type.bgColor)
                switch type.display {
                case .text(let value):
                    Text(value)
                        .foregroundStyle(Color.white)
                        .font(.largeTitle)
                case .systemImage(let value):
                    Image(systemName: value)
                        .foregroundStyle(Color.white)
                        .font(.largeTitle)
                }
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
