import Foundation

extension MSfoHeader
{
    static let kBytes:Int = 20
    private static let kElements:Int = 5
    
    //MARK: internal
    
    static func factoryHeader(
        data:Data) -> MSfoHeader?
    {
        guard
        
            let array:[UInt32] = data.arrayFromBytes(
                elements:kElements)
        
        else
        {
            return nil
        }
        
        let rawMagic:UInt32 = array[0]
        let rawVersion:UInt32 = array[1]
        let rawKeysOffset:UInt32 = array[2]
        let rawValuesOffset:UInt32 = array[3]
        let rawCount:UInt32 = array[4]
        
        let magic:Int = Int(rawMagic)
        let version:Int = Int(rawVersion)
        let keysOffset:Int = Int(rawKeysOffset)
        let valuesOffset:Int = Int(rawValuesOffset)
        let count:Int = Int(rawCount)
        
        let header:MSfoHeader = MSfoHeader(
            magic:magic,
            version:version,
            keysOffset:keysOffset,
            valuesOffset:valuesOffset,
            count:count)
        
        return header
    }
}
