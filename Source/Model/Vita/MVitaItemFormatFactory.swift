import Foundation

extension MVitaItemFormat
{
    //MARK: internal
    
    static func factoryFormat(data:Data) -> MVitaItemFormat?
    {
        guard
        
            let rawFormat:UInt16 = data.valueFromBytes()
        
        else
        {
            return nil
        }
        
        guard
        
            let format:MVitaItemFormat = MVitaItemFormat(
                rawValue:rawFormat)
        
        else
        {
            return MVitaItemFormat.unknown
        }
        
        return format
    }
}
