import Foundation

extension DVitaItemElement
{
    //MARK: internal
    
    func create(
        name:String,
        localName:String,
        dateModified:Date,
        size:UInt64,
        directory:DVitaItemDirectory)
    {
        format = MVitaItemFormat.element
        self.name = name
        self.localName = localName
        self.dateModified = dateModified.timeIntervalSince1970
        self.size = Int64(size)
        self.directory = directory
    }
}
