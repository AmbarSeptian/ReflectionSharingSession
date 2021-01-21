//
//  ContentView.swift
//  ReflectionSharingSession
//
//  Created by Ambar Septian on 13/01/21.
//

import SwiftUI

struct ContentView: View {
    @State var width: CGFloat? = nil
    var body: some View {
        Text("Puyunghai")
            .onAppear {
                
                let label = Badge(title: "sdff", image: UIImage())
                let card = ProductCard(id: 1, name: "asdfs", labels: [label])
              
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func reflect(reflecting: Any) {
    print("-----")
    let mirror = Mirror(reflecting: reflecting)
    print("\(mirror.subjectType) - \(String(describing: mirror.displayStyle))")
    
    for child in mirror.children {
        let childMirror = Mirror(reflecting: child.value)
        print("\(String(describing: child.label)) - \(String(describing: childMirror.displayStyle))")
    }
    print("-----\n ")
}



