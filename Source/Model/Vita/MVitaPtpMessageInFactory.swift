import Foundation

extension MVitaPtpMessageIn
{
    //MARK: internal
    
    class func factoryHeader(data:Data) -> MVitaPtpMessageInHeader?
    {
        guard
            
            data.count >= MVitaPtpMessageInHeader.size,
            let headerInfo:[UInt32] = data.arrayFromBytes(
                elements:MVitaPtpMessageInHeader.elements)
            
        else
        {
            return nil
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
