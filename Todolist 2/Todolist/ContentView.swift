//
//  ContentView.swift
//  Todolist
//
//  Created by 闫子龙 on 2020/1/6.
//  Copyright © 2020 闫子龙. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
        Text("Hello, World!")
            Button(action:{
            })
            {
                Text("hello again")
                .padding()
                    .background(Color.blue)
                    .foregroundColor(.black)//并不符合我们现在的设计风格
            }.cornerRadius(10)//修饰整个button
            .shadow(radius: 50)
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
