//
//  NewMessageSheetView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-11-06.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = NewMessageSheetViewModel()
    
    let selectedContact: (ContactUser) -> ()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.contacts, id: \.self){ contact in
                    Button {
                        //ContactView(contactUID: contact.uid)
                        presentationMode.wrappedValue.dismiss()
                        selectedContact(contact)
                    } label: {
                        HStack() {
                            // contact image
                            if contact.profileImageURL == "" {
                                Image("profile")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60,alignment: .leading)
                                    .cornerRadius(30)
                                    .padding()
                            } else {
                                WebImage(url: URL(string: contact.profileImageURL ))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60,alignment: .leading)
                                    .cornerRadius(30)
                                    .padding()
                            }
                            // contact username
                            VStack(alignment: .leading){
                                Text(contact.username)
                                    .font(.system(size: 16,weight: .bold))
                            }
                        }.foregroundColor(.primary)
                    }
                }
            }
            .navigationBarTitle(Text("New Message"), displayMode: .inline)
            .toolbar(){
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Text("cancel")
                    }
                }
            }
        }
    }
}

struct NewMessageSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageSheetView(selectedContact: {contact in
            print(contact)
        })
    }
}
