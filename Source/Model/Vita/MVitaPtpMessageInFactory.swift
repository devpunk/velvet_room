import Foundation

extension MVitaPtpMessageIn
{
    //MARK: internal
    
    class func factoryHeader(data:Data) -> MVitaPtpMessageInHeader?
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
        let size:Int = Int(sizeUnsigned)
        let type:UInt32 = headerInfo[1]
        
        let header:MVitaPtpMessageInHeader = MVitaPtpMessageInHeader(
            size:size,
            type:type)
        
        return header
    }
}
