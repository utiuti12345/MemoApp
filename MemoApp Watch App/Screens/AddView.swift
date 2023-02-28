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
    
    var memoViewModel = MemoViewModel()
    
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
                self.sendMessage(memo: newMemo)
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
    
    private func sendMessage(memo: Memo) {
//        let messages: [String: Any] = ["id":memo.id, "content": memo.content as Any,"createdAt":memo.createdAt as Any, "updatedAt": memo.updatedAt as Any]
        let messages: [String: Any] = ["content":memo.content, "id":memo.id]
        print("aaaaaa")
        // 動物名と絵文字を突っ込んだ配列を送信する
        self.memoViewModel.session.sendMessage(messages, replyHandler: nil) { (error) in
            print(error.localizedDescription)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
