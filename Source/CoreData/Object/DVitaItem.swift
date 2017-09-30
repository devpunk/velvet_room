import Foundation

extension DVitaItem
{
    var format:MVitaItemFormat
    {
        get
        {
            let rawFormat:UInt16 = UInt16(self.rawFormat)
            
            guard
                
                let value:MVitaItemFormat = MVitaItemFormat(
                    rawValue:rawFormat)
                
            else
            {
                return MVitaItemFormat.unknown
            }
            
            return value
        }
        
        set(newValue)
        {
            let rawFormat:Int32 = Int32(newValue.rawValue)

            self.rawFormat = rawFormat
        }
    }
    
    //MARK: internal
    
    func create(
        format:MVitaItemFormat,
        dateModified:Date)
    {
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        
        self.format = format
        self.dateModified = dateModified.timeIntervalSince1970
        dateReceived = timestamp
    }
}
