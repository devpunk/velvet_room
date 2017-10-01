import Foundation

extension DVitaItemDirectory
{
    var category:MVitaItemCategory
    {
        get
        {
            let rawCategory:UInt32 = UInt32(self.rawCategory)
            
            guard
            
                let value:MVitaItemCategory = MVitaItemCategory(
                    rawValue:rawCategory)
            
            else
            {
                return MVitaItemCategory.unknown
            }
            
            return value
        }
        
        set(newValue)
        {
            let rawCategory:Int32 = Int32(newValue.rawValue)
            
            self.rawCategory = rawCategory
        }
    }
    
    //MARK: internal
    
    func create(
        name:String,
        localName:String,
        dateCreated:Date,
        dateModified:Date,
        size:UInt64,
        category:MVitaItemCategory,
        directoryType:UInt32)
    {
        self.category = category
        self.directoryType = Int32(directoryType)
        
        create(
            name:name,
            localName:localName,
            dateCreated:dateCreated,
            dateModified:dateModified,
            size:size,
            format:MVitaItemFormat.directory)
    }
}
