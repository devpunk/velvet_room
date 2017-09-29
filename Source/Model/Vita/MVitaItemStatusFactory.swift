import Foundation

extension MVitaItemStatus
{
    private static let kNullTerminator:String = "\0"
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
        
        let subdataIdentifier:Data = data.subdata(
            start:expectedSize,
            endNotIncluding:nameEndIndex)
        
        guard
            
            var identifier:String = String(
                data:subdataIdentifier,
                encoding:String.Encoding.ascii)
            
        else
        {
            return nil
        }
        
        identifier = identifier.replacingOccurrences(
            of:kNullTerminator,
            with:String())

        let category:MVitaItemCategory = factoryCategory(
            rawCategory:rawCategory)
        let itemStatus:MVitaItemStatus = MVitaItemStatus(
            category:category,
            identifier:identifier)

        return itemStatus
    }
}
