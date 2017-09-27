import Foundation

extension MVitaLink
{
    //MARK: internal
    
    class func wrapDataWithSizeHeader(
        data:Data) -> Data
    {
        let size:UInt32 = UInt32(data.count)
        var dataWrapped:Data = Data()
        dataWrapped.append(value:size)
        dataWrapped.append(data)
        
        return dataWrapped
    }
    
    class func unwrapDataWithSizeHeader(
        data:Data) -> Data
    {
        let headerSize:Int = MemoryLayout<UInt32>.size
        let unwrappedData:Data = data.subdata(start:headerSize)
        
        return unwrappedData
    }
}
