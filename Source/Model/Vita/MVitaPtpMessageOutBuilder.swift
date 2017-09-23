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
    
    func append(data:Data)
    {
        let size:UInt32 = UInt32(data.count)
        
        self.data.append(data)
        self.size += size
        
        print("size in builder \(self.size)")
    }
    
    func append<T>(value:T)
    {
        data.append(value:value)
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
