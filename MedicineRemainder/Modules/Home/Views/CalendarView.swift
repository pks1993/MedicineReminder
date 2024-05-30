//
//  CalendarView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct CalendarView: View {
    @State var monthString: String = "Not Set"
    @EnvironmentObject var homeViewModel : HomeViewModel

    let calendar = Calendar.current
    
    var body: some View {
        
        let dates = Date().getWeek()
        
        VStack {
            Text(homeViewModel.selectedDate.getMonth())
            ScrollView(.horizontal , showsIndicators: false) {
                HStack(spacing: 0, content: {
                    ForEach(dates, id: \.self) { day in
                        VStack {
                            Text(day.getDayShort())
                                .font(.system(.caption))
                            Spacer()
                            Text("\(day.getDayNumber())")
                                .font(.system(.body))
                                .frame(width: 22 , height: 22)
                                .padding()
                                .background(Circle().fill(homeViewModel.day == day.getDayNumber() ? .blue.opacity(0.7) : .clear))
                        }
                        .onTapGesture {
                            homeViewModel.selectedDayShort = day.getDayShort()
                            homeViewModel.selectedDay = day.getDayNumber()
                            homeViewModel.selectedDate = day
                            homeViewModel.day = day.getDayNumber()
                        }
                        .frame(width: UIScreen.main.bounds.width / 7 , height: 80)
                    }
                })
            }
        }
        .onAppear {
            homeViewModel.day = Date().getDayNumber()
        }
       
    }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
       CalendarView()
            .environmentObject(HomeViewModel())
    }
}
