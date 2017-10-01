import Foundation

struct MSfoValueText:MSfoValueProtocol
{
    let format:MSfoItemFormat = MSfoItemFormat.text
    let key:MSfoKey
    let value:String
}
