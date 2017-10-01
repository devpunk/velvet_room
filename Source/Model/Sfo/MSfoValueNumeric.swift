import Foundation

struct MSfoValueNumeric:MSfoValueProtocol
{
    let format:MSfoItemFormat = MSfoItemFormat.numeric
    let key:MSfoKey
    let value:Int
}
