let jsonA = """
{
    "a": 1, "b": 123, "c": 0, "d": 0, "e": 0, "f": 1, "g": -1, "h": -2, "i": -100
}
"""

let jsonB = """
{
"a": "Lorem ipsum dolor",
"b": true,
"c": 16180
}
"""

let jsonC = """
{
    "a": [\((0..<300).map({ "\($0)" }).joined(separator: ", "))],
    "b": [\((0..<300).map({ _ in Bool.random().description }).joined(separator: ", "))],
    "c": [\((0..<300).map({ _ in Double.random(in: -1000...1000).description }).joined(separator: ", "))]
}
"""

let jsonD1 = """
{
    "a": "abcdefghijklmnopqrstuvwxyz",
    "b": 29323923932,
    "c": 82
}
"""

let jsonD2 = """
{
    "a": "abcdefghijklmnopqrstuvwxyz",
    "b": 29323923932,
    "c": \(jsonB)
}
"""
