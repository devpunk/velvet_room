import Foundation

final class MVitaPtpMessageOutBuilder
{
    private var size:UInt32
    private var data:Data
    private let kTransactionId:UInt32 = 0
    
    init()
    {
        size = 0
        data = Data()
        
        appendSize(value:size)
    }
    
    //MARK: private
    
    private func appendSize<T>(value:T)
    {
        let sizeInt:Int = MemoryLayout<T>.size
        let size:UInt32 = UInt32(sizeInt)
        self.size += size
    }
    
    //MARK: internal
    
    func append<T>(value:T)
    {
        var value:T = value
        let buffer:UnsafeBufferPointer = UnsafeBufferPointer(
            start:&value,
            count:1)
        
        data.append(buffer)
        appendSize(value:value)
    }
    
    func appendTransactionId()
    {
        append(value:kTransactionId)
    }
    
    func export() -> Data
    {
        let sizeBuffer:UnsafeBufferPointer = UnsafeBufferPointer(
            start:&size,
            count:1)
        
        var data:Data = Data(buffer:sizeBuffer)
        data.append(self.data)
        
        return data
    }
}
