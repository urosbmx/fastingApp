//
//  ProgressRing.swift
//  Fasting Timer
//
//  Created by Uroš Katanić on 22.1.22..
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager

    let timer = Timer
        .publish(every: 1,  on: .main, in: .common)
        .autoconnect()
    var body: some View {
        ZStack{
            //MARK: PlaceHolder
            
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            //MARK: Color ring
            
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress,1.0))
                .stroke(AngularGradient(gradient:Gradient(colors:[Color(#colorLiteral(red: 0.1113591716, green: 0.4475761056, blue: 0.81446594, alpha: 1)), Color(#colorLiteral(red: 0.8564867973, green: 0.1984045506, blue: 0.7963610291, alpha: 1)), Color(#colorLiteral(red: 0.9971843362, green: 0.6278832555, blue: 0.8809837699, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9622249007, blue: 0.876850307, alpha: 1)), Color(#colorLiteral(red: 0.1113591716, green: 0.4475761056, blue: 0.81446594, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
            
            VStack(spacing: 30){
                if fastingManager.fastingState == .notStarted{
                    VStack(spacing: 5){
                        Text("Upcoming fasting")
                            .opacity(0.7)
                        
                        Text("\(fastingManager.fastingPlan.fastingPeriond.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                }else{
                    // MARK: Elapsed time
                             VStack(spacing: 5){
                                 Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
                                   .opacity(0.7)
                               
                               Text(fastingManager.startTime, style: .timer)
                                   .font(.title)
                                   .fontWeight(.bold)
                           }
                           .padding(.top)
                   //MARK: Remaining time
                                           
                           VStack(spacing: 5){
                               if !fastingManager.elapse{
                                   Text("Remaining time (\((1 -  fastingManager.progress).formatted(.percent)))")

                                      .opacity(0.7)
                               }else{
                                   Text("Extra time")
                                      .opacity(0.7)
                               }
                    
                }
 
                    
                    Text(fastingManager.endTime, style: .timer)
                        .font(.title2)
                        .fontWeight(.bold)
                                    }
            }

        
            
        }
        .frame(width: 250, height: 250)
        .padding()
        
        .onReceive(timer){_ in
            fastingManager.track()
        }
      
        
        

    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(FastingManager())
    }
}
