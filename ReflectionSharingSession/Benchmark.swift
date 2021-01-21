//
//  Benchmark.swift
//  ReflectionSharingSession
//
//  Created by Ambar Septian on 21/01/21.
//

import SwiftUI


struct BenchmarkView: View {

    @State var width: CGFloat? = nil
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Text("Benchmark 10_000 items")
                .font(.headline)
            
            Button("Iterate Properties Without Mirror") {
                let start = CFAbsoluteTimeGetCurrent()
                let _ = createProductCard().map { reflectWithoutMirror(reflecting: $0)}
                let end = CFAbsoluteTimeGetCurrent()
                print(">>> no mirror \(end - start)")
            }
            .foregroundColor(.white)
            .padding(20)
            .background(Color.gray)
            
            Button("Iterate Properties With Mirror") {
                let start = CFAbsoluteTimeGetCurrent()
                let _ = createProductCard().map { reflect(reflecting: $0)}
                let end = CFAbsoluteTimeGetCurrent()
                print(">>> mirror \(end - start)")
            }
            .foregroundColor(.white)
            .padding(20)
            .background(Color.green)
            
            Button("Extract Enum Without Mirror") {
                let start = CFAbsoluteTimeGetCurrent()
                let _ = createEnums()
                    .map { extractEnum(casePath: Example.bar, root: $0) }
                let end = CFAbsoluteTimeGetCurrent()
                print(">>> enum without mirror \(end - start)")
            }
            .foregroundColor(.white)
            .padding(20)
            .background(Color.gray)
            
            Button("Extract Enum With Mirror") {
                let start = CFAbsoluteTimeGetCurrent()
                let _ = createEnums()
                    .map { extract(casePath: Example.bar, root: $0) }
                let end = CFAbsoluteTimeGetCurrent()
                print(">>> enum with mirror \(end - start)")
            }
            .foregroundColor(.white)
            .padding(20)
            .background(Color.green)
        }
    }
    
    let createProductCard: () -> [ProductCard] = {
        return (0..<100_000).enumerated().map { offset, _ in
            let label = Badge(title: "value\(offset)", image: UIImage())
            let card = ProductCard(id: offset, name: "asdfs", labels: [label])
            return card
        }
    }
    
    let createEnums: () -> [Example] = {
        return (0..<100_000).enumerated().map { offset, _ in
            if offset % 2 == 0 {
                return Example.bar("asdf")
            }
            return Example.foo(0)
        }
    }
    
    func reflect(reflecting: Any) {
        let mirror = Mirror(reflecting: reflecting)
        for child in mirror.children {
            let _ = Mirror(reflecting: child.value)
        }
    }
    
    func reflectWithoutMirror(reflecting: ProductCard) {
        // Iterate all properties manually
        let _ = reflecting.id
        let _ = reflecting.name
        
        for label in reflecting.labels {
            let _ = label.image
            let _ = label.title
        }
    }
    
    func extract<Root, Value>(casePath: (Value) -> Root, root: Root) -> Value? {
        let mirror = Mirror(reflecting: root)
        guard let child = mirror.children.first else { return nil }
        guard let value = child.value as? Value else { return nil }
        
        let newRoot = casePath(value)
        let newMirror = Mirror(reflecting: newRoot)
        guard let newChild = newMirror.children.first else { return nil }
        guard newChild.label == child.label else { return nil }
        
        return value
    }

    func extractEnum<Value: Equatable>(casePath: (Value) -> Example, root: Example) -> Value? {
        switch root {
        case let .bar(stringValue):
            if let value = stringValue as? Value, root == casePath(value) {
                return value
            }
        case let .foo(intValue):
            if let value = intValue as? Value, root == casePath(value) {
                return value
            }
        }
        
        return nil
    }

}
