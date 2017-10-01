import Foundation

extension MVitaItemCategory
{
    //MARK: internal
    
    static func factoryCategory(
        rawCategory:UInt32) -> MVitaItemCategory
    {
        guard
            
            let category:MVitaItemCategory = MVitaItemCategory(
                rawValue:rawCategory)
            
        else
        {
            return MVitaItemCategory.unknown
        }
        
        return category
    }
}
