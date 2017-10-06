import Foundation

extension MVitaPtpPackProtocol
{
    //MARK: private
    
    private static func factoryFile(
        configuration:MVitaConfiguration,
        format:MVitaItemFormat,
        size:Int64) -> Data
    {
        let compressedSize:UInt32 = UInt32(size)
        var data:Data = Data()
        
        data.append(value:
            configuration.storage.storageId)
        data.append(value:
            format.rawValue)
        data.append(value:
            configuration.storage.protectionStatus)
        data.append(value:
            compressedSize)
        
        return data
    }
    
    private static func factoryImage() -> Data
    {
        var data:Data = Data()
        
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kThumbFormat)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kThumbCompressedSize)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kThumbWith)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kThumbHeight)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kImageWith)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kImageHeight)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kImageBitDepth)
        
        return data
    }
    
    private static func factoryConfiguration(
        configuration:MVitaConfiguration) -> Data
    {
        var data:Data = Data()
        
        data.append(value:
            configuration.directory.associationType)
        data.append(value:
            configuration.directory.associationDescr)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kSequenceNumber)
        
        return data
    }
    
    private static func factoryName(
        string:String) -> Data?
    {
        guard
            
            let dataName:Data = MVitaPtpString.factoryData(
                string:string)
        
        else
        {
            return nil
        }
        
        var data:Data = Data()
        data.append(dataName)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kTerminate)
        
        return data
    }
    
    //MARK: internal
    
    static func factoryPack(
        configuration:MVitaConfiguration,
        parentHandle:UInt32,
        name:String,
        format:MVitaItemFormat,
        size:Int64) -> Data?
    {
        guard
            
            let nameData:Data = factoryName(
                string:name)
            
        else
        {
            return nil
        }
        
        let file:Data = factoryFile(
            configuration:configuration,
            format:format,
            size:size)
        let defaultImage:Data = factoryImage()
        let defaultConfiguration:Data = factoryConfiguration(
            configuration:configuration)
        
        var data:Data = Data()
        data.append(file)
        data.append(defaultImage)
        data.append(value:parentHandle)
        data.append(defaultConfiguration)
        data.append(nameData)
        
        return data
    }
}
