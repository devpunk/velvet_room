import Foundation

class MVitaPtpMessageIn
{
    let size:Int
    let type:Int
    
    init?(data:Data)
    {
        
        
        let headerInfo:[UInt32] = data.withUnsafeBytes
        { (pointer:UnsafePointer<UInt32>) -> [UInt32] in
            
            let bufferPointer:UnsafeBufferPointer = UnsafeBufferPointer(
                start:pointer,
                count:2)
            let array:[UInt32] = Array(bufferPointer)
            
            return array
        }
        
        size = headerInfo[0]
        type = headerInfo[1]
    }
}
