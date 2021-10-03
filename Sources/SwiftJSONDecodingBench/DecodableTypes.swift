struct DecodableA: Decodable {
    var a: Int
    var b: Int
    var c: Int
    var d: Int
    var e: Int
    var f: Int
    var g: Int
    var h: Int
    var i: Int
}

struct DecodableB: Decodable {
    var a: String
    var b: Bool
    var c: Int
}

struct DecodableC: Decodable {
    var a: [Int]
    var b: [Bool]
    var c: [Double]
}

struct DecodableD: Decodable {
    enum MultiplePossibilities: Decodable {
        case decodableB(DecodableB)
        case integer(Int)
    }
    
    var a: String
    var b: Int
    var c: MultiplePossibilities
    
    enum CodingKeys: CodingKey {
        case a, b, c
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.a = try container.decode(String.self, forKey: .a)
        self.b = try container.decode(Int.self, forKey: .b)
        
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .c) {
            self.c = .integer(intValue)
        } else if let decodableBValue = try? container.decodeIfPresent(DecodableB.self, forKey: .c) {
            self.c = .decodableB(decodableBValue)
        } else {
            fatalError()
        }
    }
}
