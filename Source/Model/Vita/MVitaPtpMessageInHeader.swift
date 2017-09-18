import Foundation

final class MVitaPtpMessageInHeader
{
    let size:Int
    let type:Int
    
    init?(data:Data)
    {
        guard
            
            data.count >= 8
        
        else
        {
            return nil
        }
        
        let headerInfo:[UInt32] = data.withUnsafeBytes
        { (pointer:UnsafePointer<UInt32>) -> [UInt32] in
            
            let bufferPointer:UnsafeBufferPointer = UnsafeBufferPointer(
                start:pointer,
                count:2)
            let array:[UInt32] = Array(bufferPointer)
            
            return array
        }
        
        let sizeUnsigned:UInt32 = headerInfo[0]
        let typeUnsigned:UInt32 = headerInfo[1]
        
        size = Int(sizeUnsigned)
        type = Int(typeUnsigned)
    }
}
