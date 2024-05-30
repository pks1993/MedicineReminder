//
//  NoteView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var addRemainderViewModel : AddNewRemainderViewModel
    var body: some View {
        VStack{
            HStack{
                Text("Note")
                    .font(.system(size: 15.0))
                Spacer()
            }
                
            TextEditor(text: $addRemainderViewModel.noteStr)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 80)
                .cornerRadius(10)
                .overlay(
                 RoundedRectangle(cornerRadius: 8)
                 .stroke(.gray.opacity(0.3) , lineWidth: 1)
                 .shadow(radius: 3),
                 alignment: .center
             )
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
            .environmentObject(AddNewRemainderViewModel())
    }
}
