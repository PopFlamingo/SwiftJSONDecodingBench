import Foundation


let dataA = jsonA.data(using: .utf8)!
let dataB = jsonB.data(using: .utf8)!
let dataC = jsonC.data(using: .utf8)!
let dataD1 = jsonD1.data(using: .utf8)!
let dataD2 = jsonD2.data(using: .utf8)!


let jsonDecoder = JSONDecoder()
func measurePerformance(label: String, closure: () throws -> ()) rethrows {
    let start = Date()
    try closure()
    print("\(label) took \(Date().timeIntervalSince(start)) seconds to execute")
}

let repetitions = 1_000_000

try measurePerformance(label: "JSONDecoder decode A") {
    for _ in 0..<repetitions {
        let _ = try jsonDecoder.decode(DecodableA.self, from: dataA)
    }
}

try measurePerformance(label: "Protobuf JSON decoding for A") {
    for _ in 0..<repetitions {
        let _ = try A(jsonUTF8Data: dataA)
    }
}


try measurePerformance(label: "JSONDecoder decode B") {
    for _ in 0..<repetitions {
        let _ = try jsonDecoder.decode(DecodableB.self, from: dataB)
    }
}

try measurePerformance(label: "Protobuf JSON decoding for B") {
    for _ in 0..<repetitions {
        let _ = try B(jsonUTF8Data: dataB)
    }
}

try measurePerformance(label: "JSONDecoder decode C") {
    for _ in 0..<10_000 {
        let _ = try jsonDecoder.decode(DecodableC.self, from: dataC)
    }
}

try measurePerformance(label: "Protobuf JSON decoding for C") {
    for _ in 0..<10_000 {
        let _ = try C(jsonUTF8Data: dataC)
    }
}

var total: Int = 0

try measurePerformance(label: "JSONDecoder decode D1") {
    for _ in 0..<repetitions {
        let d = try jsonDecoder.decode(DecodableD.self, from: dataD1)
        switch d.c {
        case .integer(let val):
            total += val
        case .decodableB(let b):
            total += b.c
        }
    }
}


try measurePerformance(label: "Protobuf JSON decoding for D1") {
    for _ in 0..<repetitions {
        let d = try D(jsonUTF8Data: dataD1)
        switch d.c.kind {
        case .numberValue(let number):
            total += Int(number)
        case .structValue(let structValue):
            switch structValue.fields["c"]!.kind {
            case .numberValue(let number):
                total += Int(number)
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
}


try measurePerformance(label: "JSONDecoder decode D2") {
    for _ in 0..<repetitions {
        let d = try jsonDecoder.decode(DecodableD.self, from: dataD2)
        switch d.c {
        case .integer(let val):
            total += val
        case .decodableB(let b):
            total += b.c
        }
    }
}

try measurePerformance(label: "Protobuf JSON decoding for D2") {
    for _ in 0..<repetitions {
        let d = try D(jsonUTF8Data: dataD2)
        switch d.c.kind {
        case .numberValue(let number):
            total += Int(number)
        case .structValue(let structValue):
            switch structValue.fields["c"]!.kind {
            case .numberValue(let number):
                total += Int(number)
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
}

print(total)
