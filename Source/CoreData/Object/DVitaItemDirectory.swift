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
        dateModified:Date,
        category:MVitaItemCategory)
    {
        self.category = category
        
        create(
            name:name,
            localName:localName,
            dateModified:dateModified,
            format:MVitaItemFormat.directory)
    }
}
