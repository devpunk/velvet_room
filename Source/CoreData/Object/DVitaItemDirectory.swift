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
}
