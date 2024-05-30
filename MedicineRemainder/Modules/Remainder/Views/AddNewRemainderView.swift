//
//  AddNewRemainderView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct AddNewRemainderView: View {
    @ObservedObject var addnewRemainderViewModel = AddNewRemainderViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var remainderObj : RemainderObj?
    @Binding var addRemainderViewMode : AddRemainderViewMode
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 10, content: {
                    /// note : get image view
                    getTopbarImageView()
                    
                    /// note : get medicine name title and text view
                    getMedicineNameView()
                    
                    /// note : get medicine type view
                    MedicineTypeView()
                        .environmentObject(addnewRemainderViewModel)
                    
                    /// note : get schedule time view
                    ScheduleView()
                        .environmentObject(addnewRemainderViewModel)
                    
                    /// note : get duration view
                    DurationView()
                        .environmentObject(addnewRemainderViewModel)
                    
                    /// note : get note View
                    NoteView()
                        .environmentObject(addnewRemainderViewModel)
                    
                    /// note : get save button
                    if addRemainderViewMode != .detail {
                        getSaveBtnView()
                    }
                    
                })
                .disabled(addRemainderViewMode == .detail)
                .padding()
            }
            .onTapGesture {
                // Dismiss keyboard when tapped outside of text field
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .makeCustomBackgroundView()
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Add new remainder")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .accentColor(.black)
                    },
                trailing:
                    EmptyView()
            )
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $addnewRemainderViewModel.isSuccessfullyCreated, content: {
            Alert(title: Text("Success"), message: Text("Successfully saved"), dismissButton: .default(Text("OK"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        })
        /// note show sheet /*  Daily / Weekly / Monthly */
        .actionSheet(isPresented: $addnewRemainderViewModel.isPresentDurationView, content: {
            ActionSheet(title: Text("Duration") , buttons: [
                .default(Text(DurationType.daily.getTitle()), action: {
                    addnewRemainderViewModel.selectedDuration = .daily
                }),
                .default(Text(DurationType.weekly.getTitle()), action: {
                    addnewRemainderViewModel.selectedDuration = .weekly
                }),
                .default(Text(DurationType.monthly.getTitle()), action: {
                    addnewRemainderViewModel.selectedDuration = .monthly
                }),
                .cancel()
            ])
        })
        // show sheet for date picker
        .sheet(isPresented: $addnewRemainderViewModel.isPresentDatePickerSheet, content: {
            DatePickerSheetView()
                .environmentObject(addnewRemainderViewModel)
                .frame(height: 250)
        })
        // called when content view appear
        .onAppear(perform: {
            if let obj = remainderObj ,
               addRemainderViewMode != .addNew {
                addnewRemainderViewModel.medicineName = obj.medicineName
                addnewRemainderViewModel.medicineType = MedicineType(rawValue: obj.medicineType) ?? .tablets
                addnewRemainderViewModel.scheduleTime = ScheduleTime(rawValue: obj.scheduleType) ?? .afterWakeUp
                addnewRemainderViewModel.durationType = DurationType(rawValue: obj.durationType) ?? .daily
                addnewRemainderViewModel.noteStr = obj.noteStr
                addnewRemainderViewModel.selectedDate = obj.remainderDate.convertToDateString(formatter: .dateOnly)
                addnewRemainderViewModel.selectedTime = obj.remainderTime.convertToDateString(formatter: .timeOnly)
            }
        })
        
    }
    
    @ViewBuilder
    private func getTopbarImageView() -> some View {
        VStack {
            // Heart Image in the center
            Image(systemName: "heart.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .foregroundColor(.red)
            
            // Text wrapped around the heart
            Text("Health is a journey, not a destination. Let us help you along the way.")
                .foregroundColor(.red.opacity(0.7))
                .multilineTextAlignment(.center)
            
                Spacer()
        }
    }
    
    @ViewBuilder
    private func getMedicineNameView() -> some View {
        VStack{
            HStack{
                Text("Medicine Name")
                    .font(.system(size: 15.0))
                Spacer()
            }
            
            TextEditor(text: $addnewRemainderViewModel.medicineName)
                           .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 60)
                           .cornerRadius(10)
                           .overlay(
                            RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray.opacity(0.3) , lineWidth: 1)
                            .shadow(radius: 3),
                            alignment: .center
                        )
            
        }
        
    }
    
    @ViewBuilder
    private func getSaveBtnView() -> some View {
        Button {
            let obj = addnewRemainderViewModel.createObj()
            if addRemainderViewMode == .addNew {
                addnewRemainderViewModel.addNewRemainder(remainderObj: obj)
            }
            else {
                obj.objId = remainderObj?.objId ?? ""
                addnewRemainderViewModel.updateNewRemainderById(remainderObj: obj)
            }
            
        } label: {
            Text("Save")
                .font(.system(size: 15.0))
                .foregroundColor(.black.opacity(addnewRemainderViewModel.isActiveSave ? 0.7 : 0.3))
        }
        .frame(width: 150 , height: 50)
        .disabled(!addnewRemainderViewModel.isActiveSave)
        .background(Color.blue.opacity(addnewRemainderViewModel.isActiveSave ? 0.7 : 0.3))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(style: .init( lineWidth: 1)).foregroundColor(.clear).shadow(radius: 3 , x : 2 , y : 2), alignment: .center)
        .padding()
    }
    
    
}


struct AddNewRemainderView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewRemainderView(remainderObj: .constant(nil) , addRemainderViewMode: .constant(.detail))
    }
}
