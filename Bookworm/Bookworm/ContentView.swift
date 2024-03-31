//
//  ContentView.swift
//  Bookworm
//
//  Created by saliou seck on 30/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.title),
                  SortDescriptor(\Book.author)]) var books: [Book]

    @State private var showingAddScreen = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }.onDelete(perform: deleteBook)
            }
            .navigationDestination(for: Book.self, destination: { book in
                DetailView(book: book)
            })
               .navigationTitle("Bookworm")
               .toolbar {
                   ToolbarItem(placement: .topBarLeading) {
                       EditButton()
                   }
                   ToolbarItem(placement: .topBarTrailing) {
                       Button("Add Book", systemImage: "plus") {
                           showingAddScreen.toggle()
                       }
                   }
               }
               .sheet(isPresented: $showingAddScreen) {
                   AddBookView()
               }
       }
     }
    
    func deleteBook(at offsets: IndexSet){
        for offset in offsets{
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
