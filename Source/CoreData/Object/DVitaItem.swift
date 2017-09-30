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
        format:MVitaItemFormat)
    {
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        
        self.name = name
        self.localName = localName
        self.format = format
        self.dateModified = dateModified.timeIntervalSince1970
        dateReceived = timestamp
    }
}
