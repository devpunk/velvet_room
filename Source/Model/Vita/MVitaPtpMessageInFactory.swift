import Foundation

extension MVitaPtpMessageIn
{
    //MARK: internal
    
    class func factoryHeader(
        data:Data) -> MVitaPtpMessageInHeader?
    {
        guard
            
            data.count >= MVitaPtpMessageInHeader.kSize,
            let headerInfo:[UInt32] = data.arrayFromBytes(
                elements:MVitaPtpMessageInHeader.kElements)
            
        else
        {
            return nil
        }
        
        let sizeUnsigned:UInt32 = headerInfo[0]
        let size:Int = Int(sizeUnsigned)
        let rawType:UInt32 = headerInfo[1]
        let type:MVitaPtpType
        
        if let ptpType:MVitaPtpType = MVitaPtpType(rawValue:rawType)
        {
            type = ptpType
        }
        else
        {
            type = MVitaPtpType.unknown
        }
        
        let header:MVitaPtpMessageInHeader = MVitaPtpMessageInHeader(
            type:type,
            size:size)
        
        return header
    }
    
    class func factoryCommand(
        rawCode:UInt16) -> MVitaPtpCommand
    {
        let command:MVitaPtpCommand
        
        if let code:MVitaPtpCommand = MVitaPtpCommand(
            rawValue:rawCode)
        {
            command = code
        }
        else
        {
            command = MVitaPtpCommand.unknown
        }
        
        return command
    }
}
