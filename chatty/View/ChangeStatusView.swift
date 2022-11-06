//
//  ChangeStatusView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-27.
//

import SwiftUI

struct ChangeStatusView: View {
    
    @State var isUpdateFaild: Bool = false
    @State var alertMessage: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var items = ["Available", "Busy", "At work", "Gym time", "Sleep", "Travel"]
    
    @State var selectedItem: String = ""

    var const = Constant()
    
    @ObservedObject var vm = MainViewModel()
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                SelectionRow(title: item, selectedItem: $selectedItem)
            }
        }
        .navigationBarItems(trailing: Button(action: {
            changeStatus(status: selectedItem)
        }, label: {
            Text("Save")
        }))
        .onAppear(){
            self.selectedItem = vm.currentUser?.status ?? ""
        }
        // alert: username updated
        .alert(alertMessage, isPresented: $isUpdateFaild) {
            Button("Ok", role: .cancel) { }
        }
    }
        
    
    // TODO: alert if not updated
    func changeStatus(status: String){
        print("saved status \(status)")
        let uid = vm.currentUser!.uid
        
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(uid).updateData(["status" : status]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                self.alertMessage = "error: \(err.localizedDescription)"
                self.isUpdateFaild = true
            } else {
                print("Document successfully updated")
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        

    }
}

struct SelectionRow: View {
    typealias Action = (String) -> Void
    
    let title: String
    @Binding var selectedItem: String
    var action: Action?
    
    var body: some View{
        HStack{
            Text(title)
            Spacer()
            if title == selectedItem{
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedItem = title
            
            if let action = action{
                action(title)
            }
            
        }
    }
}
struct ChangeStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeStatusView()
    }
}
