import Foundation

extension MVitaItemStatus
{
    private static let kParameters:Int = 2
    
    //MARK: private
    
    private static func factoryCategory(
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
    
    //MARK: internal
    
    static func factoryStatus(data:Data) -> MVitaItemStatus?
    {
        let parameterSize:Int = MemoryLayout<UInt32>.size
        let expectedSize:Int = parameterSize * kParameters
        
        guard
            
            data.count >= expectedSize
            
        else
        {
            return nil
        }
        
        guard
            
            let parameters:[UInt32] = data.arrayFromBytes(
                elements:kParameters),
            let rawCategory:UInt32 = parameters.first,
            let nameLength:UInt32 = parameters.last
            
        else
        {
            return nil
        }
        
        let nameLengthInt:Int = Int(nameLength)
        let nameEndIndex:Int = expectedSize + nameLengthInt
        
        guard
            
            data.count >= nameEndIndex
        
        else
        {
            return nil
        }
        
        let subdataName:Data = data.subdata(
            start:expectedSize,
            endNotIncluding:nameEndIndex)
        
        guard
            
            let name:String = String(
                data:subdataName,
                encoding:String.Encoding.ascii)
            
        else
        {
            return nil
        }

        let category:MVitaItemCategory = factoryCategory(
            rawCategory:rawCategory)
        let itemStatus:MVitaItemStatus = MVitaItemStatus(
            category:category,
            name:name)

        return itemStatus
    }
}
