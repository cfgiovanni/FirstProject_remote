//
//  ContentView.swift
//  FirstProject
//
//  Created by Giovanni Ciappina Feijo on 10/17/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "👽", "🐰", "😈", "🦊", "👻", "👽", "🐰"]
    @State var cardCounter: Int = 2
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            HStack{
                addButton
                Spacer()
                removeButton
            }
            .padding(12)
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(),GridItem()]) {
            ForEach (0..<cardCounter, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    func cardCount(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCounter += offset
        }, label: {
            Image(systemName: symbol)
        })
        .buttonStyle(.borderedProminent)
        .disabled(cardCounter+offset<1 || cardCounter+offset>emojis.count)
    }
    
    var addButton: some View {
        cardCount(by: 1, symbol: "plus")
    }
    
    var removeButton: some View {
        cardCount(by: -1, symbol: "minus")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.blue)
                Text(content+String(isFaceUp)).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill(.yellow).opacity(isFaceUp ? 0 : 1)
        }.onTapGesture (count: 1, perform: ({
            //isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }))
        .padding([.bottom, .horizontal], 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
