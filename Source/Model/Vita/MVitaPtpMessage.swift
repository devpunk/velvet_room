import Foundation

final class MVitaPtpMessage
{
    private(set) var data:Data
    
    init()
    {
        data = Data()
    }
    
    //MARK: internal
    
    func append<T>(value:T)
    {
        var value:T = value
        let pointer:UnsafeBufferPointer = UnsafeBufferPointer(
            start:&value,
            count:1)
        
        data.append(pointer)
    }
}
