//
//  EditView.swift
//  MemoApp Watch App
//
//  Created by saotome on 2023/02/27.
//

import SwiftUI

struct EditView: View {
    private var memo: Memo
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @State private var content = ""
    
    init(memo: Memo) {
        self.memo = memo
        //self.title = memo.title ?? ""
        self._content = State(initialValue: memo.content!)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            TextField("Enter your name", text: $content)
            Button(action: {
                saveMemo()
            }) {Text("保存")}
        }
    }
    
    private func saveMemo() {
        withAnimation {
            memo.content = content
            memo.updatedAt = Date()

            do {
                try viewContext.save()
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

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(memo: Memo())
    }
}

