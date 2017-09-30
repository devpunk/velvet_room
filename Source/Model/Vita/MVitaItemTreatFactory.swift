import Foundation

extension MVitaItemTreat
{
    private static let kElements:Int = 3
    
    //MARK: internal
    
    static func factoryTreat(
        data:Data) -> MVitaItemTreat?
    {
        guard
        
            var rawElements:[UInt32] = data.arrayFromBytes(
                elements:kElements),
            let treatId:UInt32 = rawElements.popLast(),
            let directoryType:UInt32 = rawElements.popLast(),
            let rawCategory:UInt32 = rawElements.popLast(),
            let category:MVitaItemCategory = MVitaItemCategory(
                rawValue:rawCategory)
        
        else
        {
            return nil
        }
        
        let itemTreat:MVitaItemTreat = MVitaItemTreat(
            category:category,
            treatId:treatId,
            directoryType:directoryType)
        
        return itemTreat
    }
}
