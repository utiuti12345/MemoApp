//
//  MainView.swift
//  MemoApp Watch App
//
//  Created by saotome on 2023/02/26.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.updatedAt, ascending: false)],
        animation: .default)
    private var memos: FetchedResults<Memo>
    
    var body: some View {
        NavigationStack{
            ZStack {
                List {
                    ForEach(memos) { memo in
                        NavigationLink(destination: EditView(memo: memo)) {
                            Text("\(memo.content!)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                FloatingButton()
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { memos[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

}

struct FloatingButton: View {
    @State var showModal = false
    
    var body: some View {
        VStack {  // --- 1
            Spacer()
            HStack { // --- 2
                Spacer()
                Button(
                    action:{self.showModal.toggle()})
                    {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .font(.system(size: 24)) // --- 4
                }
                .frame(width: 50, height: 50)
                .background(Color.orange)
                .cornerRadius(30.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -15, trailing: 2.0)) // --- 5
                .sheet(isPresented: self.$showModal) {
                    AddView()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
