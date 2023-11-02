//
//  ContentView.swift
//  swift-calculator
//
//  Created by MA on 02/11/2023.
//

import SwiftUI




class EnvrinmentViewModel : ObservableObject {
    
    @Published var display : String = ""
    
   
    
    func calculatorDisplay(button : CalculatorButtons) {
        self.display += button.title
    }
    
    func clearDisplay() {
        self.display = ""
    }
    
    func evaluate() {
           if let plusIndex = self.display.firstIndex(of: "+") {
               
               print("checkPlusIndex \(plusIndex)")
               
               let firstNumber = Int(self.display.prefix(upTo: plusIndex)) ?? 0
               
               let secondNumber = Int(self.display.suffix(from: display.index(plusIndex, offsetBy: 1))) ?? 0
               
               self.display = String(firstNumber + secondNumber)
           } else if let minusIndex = self.display.firstIndex(of: "-") {
               let firstNumber = Int(self.display.prefix(upTo: minusIndex)) ?? 0
               let secondNumber = Int(self.display.suffix(from: display.index(minusIndex, offsetBy: 1))) ?? 0
               self.display = String(firstNumber - secondNumber)
           }else if let divideIndex = self.display.firstIndex(of: "/") {
               let firstNumber = Int(self.display.prefix(upTo: divideIndex)) ?? 0
               let secondNumber = Int(self.display.suffix(from: display.index(divideIndex, offsetBy: 1))) ?? 0
               self.display = String(firstNumber / secondNumber)
           }else if let multiplyIndex = self.display.firstIndex(of: "X") {
               let firstNumber = Int(self.display.prefix(upTo: multiplyIndex)) ?? 0
               let secondNumber = Int(self.display.suffix(from: display.index(multiplyIndex, offsetBy: 1))) ?? 0
               self.display = String(firstNumber * secondNumber)
           }else if let modulesIndex = self.display.firstIndex(of: "%") {
               let firstNumber = Int(self.display.prefix(upTo: modulesIndex)) ?? 0
               let secondNumber = Int(self.display.suffix(from: display.index(modulesIndex, offsetBy: 1))) ?? 0
               self.display = String(firstNumber % secondNumber)
           }

           
       }
    
        
}

enum CalculatorButtons : String {
    
    case ac, plusMinus,module,divide
    case seven,eight,nine,multiply
    case four,five,six,minus
    case one,two,three,plus
    case zero,dot,equal
    
    
    var title : String {
        
        switch self {
        case .ac : return "AC"
        case .plusMinus : return "+/"
        case .module : return "%"
        case .divide : return "/"
        case .seven : return "7"
        case .eight : return "8"
        case .nine : return "9"
        case .multiply : return "X"
        case .four : return "4"
        case .five : return "5"
        case .six : return "6"
        case .minus : return "-"
        case .one : return "1"
        case .two : return "2"
        case .three : return "3"
        case .plus : return "+"
        case .zero : return "0"
        case .dot : return "."
        case .equal : return "="
      
        }
        
        
    }
    
    var backgroundColor : Color {
        
        switch self {
        case .ac,.plusMinus,.module :
            return Color(.gray)
        case .divide,.multiply,.minus,.plus,.equal :
            return Color(.orange)
            
        default :
            return Color(.lightGray)
            
            
        }
        
    }
    
    
}

struct ContentView: View {
    
    
    @State var buttonController : String = ""
    
    @EnvironmentObject var env : EnvrinmentViewModel
    
    let buttons : [[CalculatorButtons]] = [
        [.ac,.plusMinus,.module,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.minus],
        [.one,.two,.three,.plus],
        [.zero,.dot,.equal],
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
      
            
            VStack(spacing:12) {
                
                HStack {
                    Spacer()
                    Text(env.display).font(.system(size: 45)).foregroundColor(.white)
                }
                
                
                ForEach(buttons, id : \.self) {
                    row in
                    
                   
                    HStack {
                        
                        ForEach (row, id: \.self) {
                            button in
                            
                            
                            
                            Button {
                               
                                
                               
                                buttonActions(button: button)
                               
                                
                            } label: {
                                Text(button.title)
                                    .foregroundColor(.white)
                                    .frame(width: buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12 ) /  4, alignment: .center).background(button.backgroundColor)
                                        .cornerRadius(50)
                                
                                
                            }

                       
                            
                        }
                            
                        
                    }
                    
                }
            }.padding()
            
            
        }
    }
    
    
    
    
    
    
    func buttonWidth(button : CalculatorButtons) -> CGFloat {
        
        if (button == .zero) {
            return (UIScreen.main.bounds.width - 5 * 12 ) /  4 * 2
        }
        
        return (UIScreen.main.bounds.width - 5 * 12 ) /  4
    }
    
    
    private func buttonActions(button : CalculatorButtons) {
        
        
        
        switch (button) {
        case .ac :
            env.clearDisplay()
        case .equal :
            env.evaluate()
            
            
            
        default :
            env.calculatorDisplay(button: button)
        }
        
    }
    
    
}



#Preview {
    ContentView().environmentObject(EnvrinmentViewModel())
}
