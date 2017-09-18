import Foundation

class MVitaPtpMessageOut
{
    private var size:UInt32
    private var data:Data
    
    init()
    {
        size = 0
        data = Data()
        
        appendSize(value:size)
    }
    
    //MARK: private
    
    private func appendSize<T>(value:T)
    {
        let sizeInt:Int = MemoryLayout.size(
            ofValue:value)
        let size:UInt32 = UInt32(sizeInt)
        self.size += size
    }
    
    //MARK: internal
    
    final func append<T>(value:T)
    {
        var value:T = value
        let pointer:UnsafeBufferPointer = UnsafeBufferPointer(
            start:&value,
            count:1)
        
        data.append(pointer)
        appendSize(value:value)
    }
    
    final func export() -> Data
    {
        let pointer:UnsafeBufferPointer = UnsafeBufferPointer(
            start:&size,
            count:1)
        
        var data:Data = Data(buffer:pointer)
        data.append(self.data)
        
        return data
    }
}
