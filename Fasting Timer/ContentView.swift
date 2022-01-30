//
//  ContentView.swift
//  Fasting Timer
//
//  Created by Uroš Katanić on 22.1.22..
//


import SwiftUI

struct ContentView: View {
    @StateObject var fastingMenager = FastingManager()
 
    
    
    var title: String{
        switch fastingMenager.fastingState{

        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }
    var body: some View {
        ZStack{
            // Mark: Background
            
            Color(#colorLiteral(red: 0.1030700281, green: 0.01214229781, blue: 0.1682200432, alpha: 1))
                .ignoresSafeArea()
            
            content
        }
    }
    
    var content: some View{
        ZStack{
            VStack(spacing: 40){
                //MARK: Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.1113591716, green: 0.4475761056, blue: 0.81446594, alpha: 1)))
                
                //MARK: Fasting plan
                
                Text (fastingMenager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                Spacer()
            }
            VStack(spacing: 40){
                ProgressRing()
                    .environmentObject(fastingMenager)
                
                HStack(spacing: 60){
                    //MARK: Start TIME
                    
                    VStack(spacing: 5){
                        Text(fastingMenager.fastingState == .notStarted ? "Start": "Started")
                            .opacity(0.7)
                        
                        Text(fastingMenager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    //MARK: End TIME
                    
                    VStack(spacing: 5){
                        Text(fastingMenager.fastingState == .notStarted ? "End": "Ends")
                            .opacity(0.7)
                        
                        Text(fastingMenager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
//                Spacer()
                HStack{
                    //MARK: Button
                    
                    Button{
                        fastingMenager.toogleFastingState()
                    }label: {
                        Text (fastingMenager.fastingState == .fasting ? "End fast": "Start fasting")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                        
                    }
//                    Spacer()
                    Button{
                        fastingMenager.toogleFasting()
                    }label: {
                        Text ("Change plan")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                            .padding()
                            
                        
                    }
                    .disabled(fastingMenager.fastingActive)

                }
                
      
                
                
        
            }
            
            
            
        }

        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
