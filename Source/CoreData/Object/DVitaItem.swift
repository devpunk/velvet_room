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
        name:String,
        localName:String,
        dateModified:Date,
        size:UInt64,
        format:MVitaItemFormat)
    {
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        
        self.name = name
        self.localName = localName
        self.dateModified = dateModified.timeIntervalSince1970
        self.size = Int64(size)
        self.format = format
        dateReceived = timestamp
    }
}
