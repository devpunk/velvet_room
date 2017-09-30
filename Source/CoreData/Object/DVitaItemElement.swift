import Foundation

extension DVitaItemElement
{
    var fileExtension:MVitaItemInExtension
    {
        get
        {
            guard
            
                let rawFileExtension:String = self.rawFileExtension,
                let fileExt:MVitaItemInExtension = MVitaItemInExtension(
                    rawValue:rawFileExtension)
            
            else
            {
                return MVitaItemInExtension.unknown
            }
            
            return fileExt
        }
        
        set(newValue)
        {
            let rawFileExtension:String = newValue.rawValue
            self.rawFileExtension = rawFileExtension
        }
    }
    
    //MARK: internal
    
    func create(
        name:String,
        localName:String,
        dateModified:Date,
        size:UInt64,
        directory:DVitaItemDirectory)
    {
        self.name = name
        self.localName = localName
        self.size = Int64(size)
        self.directory = directory
        
        create(
            format:MVitaItemFormat.element,
            dateModified:dateModified)
    }
}
