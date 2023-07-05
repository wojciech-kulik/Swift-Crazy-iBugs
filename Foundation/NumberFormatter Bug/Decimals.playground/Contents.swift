import Foundation

let formatter = NumberFormatter()
formatter.generatesDecimalNumbers = true
formatter.numberStyle = .decimal
formatter.locale = .init(identifier: "en_US")
/*:Parsing Decimals using initializer */
8.11 as Decimal

let decimal = Decimal(string: "8.11")!
let cents = decimal * 100.0
let centsAsInt = (cents as NSNumber).intValue
/*:Parsing Decimals using `NumberFormatter` */
formatter.number(from: "8.11") as? NSDecimalNumber

let formatterDecimal = formatter.number(from: "8.11")?.decimalValue ?? 0
let formatterCents = formatterDecimal * 100.0
let formatterCentsAsInt = (formatterCents as NSNumber).intValue
