import Foundation

extension DVitaItem
{
    private static let kDefaultDate:TimeInterval = 0
    
    //MARK: internal
    
    func config(item:MVitaItemIn)
    {
        if let dateCreated:Date = item.dateCreated
        {
            self.dateCreated = dateCreated.timeIntervalSince1970
        }
        else
        {
            self.dateCreated = DVitaItem.kDefaultDate
        }
        
        if let dateModified:Date = item.dateModified
        {
            self.dateModified = dateModified.timeIntervalSince1970
        }
        else
        {
            self.dateModified = DVitaItem.kDefaultDate
        }
        
        if let localName:String = item.localName
        {
            self.localName = localName
        }
        else
        {
            self.localName = String()
        }
        
        format = item.format
        size = Int64(item.size)
        dateReceived = Date().timeIntervalSince1970
    }
}
