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
                
                let asdf = Example.foo(2)
//                print(extract(casePath: Example.foo, root: asdf))
//                print(extract(casePath: Example.bar, root: asdf))
                reflect(reflecting: label)
                reflect(reflecting: card)
                reflect(reflecting: asdf)
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
//
//func reflect(reflecting: Any) {
//    let reflection = Mirror(reflecting: reflecting)
//    print("\(reflection.subjectType) - \(String(describing: reflection.displayStyle))")
//
//    for child in reflection.children {
//        let childMirror = Mirror(reflecting: child.value)
//        print("\(child.label ?? "") - \(String(describing: childMirror.displayStyle))")
//    }
//}
