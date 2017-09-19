import Foundation

struct MVitaPtpMessageInHeader
{
    static let size:Int = 8
    static let elements:Int = 2
    
    let size:Int
    let type:UInt32
}
