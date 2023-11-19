//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Amarildo João Custódio Lucas on 18/11/23.
//

import SwiftUI
struct WeatherInfo {
    let day: String
    let temperature: Int
    let isRainy: Bool
}


struct ContentView: View {
    
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri","Sat", "Sun"]
    
    @State private var selectedDay: String?
    //@State private var selectedBackground: Color = .white
    @State private var isExpanted = false
    
    let weatherData: [WeatherInfo] = [WeatherInfo(day: "Mon", temperature: 40, isRainy: false), WeatherInfo(day: "Tue", temperature: 10, isRainy: true), WeatherInfo(day: "Wed", temperature: 36, isRainy: false), WeatherInfo(day: "Thu", temperature: 30, isRainy: true), WeatherInfo(day: "Fri", temperature: 26, isRainy: true),WeatherInfo(day: "Sat", temperature: 33, isRainy: true), WeatherInfo(day: "Sun", temperature: 22, isRainy: true)
    ]
    
    
    var body: some View {

        VStack{
            Spacer()
            
            HStack(spacing:20) {
                ForEach(daysOfWeek, id: \.self) {
                    day in DayButton(day: day, onTap: {
                        self.selectedDay = day
                        self.isExpanted = true
                       // selectedBackground = weatherColor(temperature: 40)
                    })
                }
            }
            .padding()
            .background(Color.white)
            .shadow(radius: 10)
    
        
            
            
            
            Spacer()
            
            if let selectedDay = selectedDay,let weatherInfo = weatherData.first(where: { $0.day == selectedDay
            }) {
                WeatherDetailView(weatherInfo: weatherInfo, isExpanded: $isExpanted)
                    
            }
        }
        .navigationBarTitle("Rio de Janeiro, RJ", displayMode: .inline)
        .frame(maxWidth: .infinity)
        .padding()
        //.background(selectedBackground)
        
    }
    
    @ViewBuilder
    private func weatherColor(temperature: Int) -> Color {
        if temperature <= 20 {
            return Color.white
        } else {
            return Color.orange
        }
        
    }
}


struct DayButton : View {
    let day: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            
            VStack {
                Text(day)
                Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 17, height: 60)
                    .overlay(Circle()
                        .stroke(Color.blue, lineWidth: 5)
                        .shadow(color: Color.blue.opacity(100), radius: 5, x: 0)
                    )
                
                    
                    
                    
            }
        }
    
    }

    }

struct WeatherDetailView : View {
    let weatherInfo: WeatherInfo
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack {
            Text(weatherInfo.day)
                .font(.title)
                .padding()
            
            Text("Temperature: \(weatherInfo.temperature)")
                .padding()
            
            if weatherInfo.isRainy {
                WeatherAnimationView(animation: .flames)}
            else {
                WeatherAnimationView(animation: .cloud)
            }
        }
        
        .cornerRadius(20)
        .padding()
        .offset(y: isExpanded ? 0 : UIScreen.main.bounds.height)
    }
    }
enum WeatherAnimation {
    case rain
    case cloud
    case flames
}


struct WeatherAnimationView : View {
    
    let animation: WeatherAnimation
    
    var body: some View {
        switch animation {
        case .rain:
            return AnyView(RainView())
        case .cloud:
            return AnyView(CloudView())
        case .flames:
            return AnyView(FlamesView())
        }
    }
}

struct RainView : View {
    var body: some View {
      Circle()
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .frame(width: 100, height: 100)
    }
}

struct CloudView: View {
    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.green)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
    }
}


struct FlamesView: View {
    var body: some View {
        
        Image(systemName: "flame.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.orange)
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
    }
}

// ContentView: View {
//    var body: some View {
//      HStack {
//          DayForecast(day: "Seg", isRainy: false, high: 70, low: 50)
//
//
//         DayForecast(day: "Ter", isRainy: true, high: 60, low: 40)
            
//          DayForecast(day: "Qua", isRainy: true, high: 60, low: 40)
                        
//       }
//       .padding(0)
        //.background(Color.yellow)
//   }
//}

#Preview {
    ContentView()
}

//struct DayForecast: View {
//    let day: String
//   let isRainy: Bool
//   let high : Int
//   let low : Int
    
//   @State var text = ""
    
//  var iconName : String {
//       if isRainy {
//                 return "cloud.rain.fill"
//             } else {
//                 return "sun.max.fill"
//              }
//  }
    
//   var iconColor: Color {
//       if isRainy {
//           return Color.blue
//      } else {
//          return Color.yellow
//      }
//  }
    
//   var body: some View {
//       VStack {
//           Text(day)
//              .font(.headline)
//          Image(systemName: iconName)
//              .foregroundStyle(iconColor)
//               .font(.largeTitle)
//              .padding(5)
//              .onTapGesture {
//                  text = "Hello"
//               }
//           Text("High: \(high)")
//                           .fontWeight(Font.Weight.semibold)
//                      Text("Low: \(low)")
//                          .fontWeight(Font.Weight.medium)
//                          .foregroundStyle(Color.secondary)
//          Text(text)
//       }
//       .padding()
//   }
//}


//Practice using computed properties. Add a computed property to return different colors if the high temperature is above 80 (high > 80). Use the .foregroundStyle modifier to change the text color depending on the value of the property.

//Practice creating custom views. Go back to your ChatPrototype project and create a new view named ChatBubble. Use properties to represent the bubble’s text and color. Use your custom view in ContentView.



