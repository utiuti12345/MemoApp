//
//  AddView.swift
//  MemoApp Watch App
//
//  Created by saotome on 2023/02/26.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @State private var content = ""
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            TextField("", text: $content)
                .focused($fieldIsFocused)
            Button(action: {
                if(content == ""){
                    fieldIsFocused = true
                }else{
                    addItem()
                    fieldIsFocused = false
                }
            }) {Text("追加")}
                .frame(width: 90, height: 20)
        }
    }
    
    private func clear(){
        content = ""
    }
    
    private func addItem() {
        withAnimation {
            let newMemo = Memo(context: viewContext)
            newMemo.id = UUID()
            newMemo.content = content
            newMemo.createdAt = Date()
            newMemo.updatedAt = Date()

            do {
                try viewContext.save()
                clear()
                presentation.wrappedValue.dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
