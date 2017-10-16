import Foundation

struct MSfoHeader
{
    let magic:Int
    let version:Int
    let keysOffset:Int
    let valuesOffset:Int
    let count:Int
}
