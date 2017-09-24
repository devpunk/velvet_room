import Foundation

struct MVitaPtpMessageInHeader
{
    static let kSize:Int = 8
    static let kElements:Int = 2
    
    let type:MVitaPtpType
    let size:Int
}
