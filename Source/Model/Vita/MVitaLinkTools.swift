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
    
    class func loadData(
        resourceName:String,
        resourceExtension:String) -> Data?
    {
        guard
            
            let url:URL = Bundle.main.url(
                forResource:resourceName,
                withExtension:resourceExtension)
            
        else
        {
            return nil
        }
        
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:url,
                options:Data.ReadingOptions())
        }
        catch
        {
            return nil
        }
        
        return data
    }
}
