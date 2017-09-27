import Foundation

extension MVitaItemStatus
{
    private static let kParameters:Int = 2
    
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
            let itemId:UInt32 = parameters.first,
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
            start:parameterSize,
            endNotIncluding:nameEndIndex)
        
        guard
            
            let name:String = String(
                data:subdataName,
                encoding:String.Encoding.utf8)
            
        else
        {
            return nil
        }
        
        let itemStatus:MVitaItemStatus = MVitaItemStatus(
            name:name,
            itemId:itemId)
        
        return itemStatus
    }
}
