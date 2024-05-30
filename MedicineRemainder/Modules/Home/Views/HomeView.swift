//
//  HomeView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
   
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 10)
                /// note : get calendar view for Home top
                CalendarView()
                    .environmentObject(homeViewModel)
                
                Spacer()
                    .frame(height: 10)
                
                /// note : get date type view
                DateTypeView()
                    .environmentObject(homeViewModel)
                
                /// note : check is exist data or not in DB
                if homeViewModel.isEmptyData {
                    getEmptyView()
                }
                else {
                    getRemainderItemsView()
                }
                
                NavigationLink(
                    destination: AddNewRemainderView(remainderObj: .constant(homeViewModel.selectedRemainder) , addRemainderViewMode: .constant(.edit)),
                    isActive: $homeViewModel.isNavigateToEditView,
                    label: {
                        EmptyView()
                    })
                
                NavigationLink(
                    destination: AddNewRemainderView(remainderObj: .constant(homeViewModel.selectedRemainder), addRemainderViewMode: .constant(.detail)),
                    isActive: $homeViewModel.isNavigateToDetailView,
                    label: {
                        EmptyView()
                    })

            }
            .makeCustomBackgroundView()
            .navigationBarItems(
                leading: Text("Your medicines remainder")
                    .font(.system(size: 15.0)),
                trailing: NavigationLink {
                    AddNewRemainderView(remainderObj: .constant(nil) , addRemainderViewMode: .constant(.addNew))
                } label: {
                    Text("Add New")
                        .font(.system(size: 15.0))
                        .foregroundColor(.blue)
                })
            
            .onAppear {
                homeViewModel.getAllNewRemainders()
            }
            .alert(isPresented: $homeViewModel.isShowDeletedAlert, content: {
                Alert(title: Text("Information") , message: (homeViewModel.isDeletedCurrentValueSubject.value ?? false) == true ? Text("Successfully Deleted!") : Text("Failed to delete!") , dismissButton: .destructive(Text("OK")))
            })
            .actionSheet(isPresented: $homeViewModel.isPresentBottomSheetAlert, content: {
                ActionSheet(title: Text("More action") , buttons: [
                    .default(Text("Edit"), action: {
                        homeViewModel.isNavigateToEditView = true
                    }),
                    .destructive(Text("Delete"), action: {
                        homeViewModel.deletRemainderById(remainderId: homeViewModel.selectedRemainder?.objId ?? "")
                    }),
                    .cancel()
                ])
            })
        }
        
    }
    
    @ViewBuilder
    private func getRemainderItemsView() -> some View {
        ScrollView(.vertical , showsIndicators: false) {
            if !homeViewModel.allRemainders.isEmpty {
                ForEach(homeViewModel.allRemainders) {remainder in
                    VStack {
                        RemainderItemView(remainderObj: .constant(remainder))
                            .onTapGesture {
                                homeViewModel.isNavigateToDetailView = true
                            }
                            .environmentObject(homeViewModel)
                    }
                    

                }
            }
            else{
                getEmptyView()
            }
            
        }
        .padding()
    }
    
    @ViewBuilder
    private func getEmptyView() -> some View {
        VStack{
            Spacer()
            Image(systemName: "list.bullet")
                .resizable()
                .frame(width: 30 , height: 30)
            Spacer()
                .frame(height: 10)
            Text("There is no remainder!")
                .font(.system(size: 15.0))
                .foregroundColor(.black)
            Spacer()
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel())
    }
}
