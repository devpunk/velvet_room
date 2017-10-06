import Foundation

struct MVitaPtpPackDirectory:MVitaPtpPackProtocol
{
    let data:Data
    
    init?(
        directory:DVitaItemDirectory,
        configuration:MVitaConfiguration,
        parentHandle:UInt32)
    {
        guard
            
            let name:String = directory.identifier?.identifier,
            let dataName:Data = MVitaPtpString.factoryData(
                string:name)
        
        else
        {
            return nil
        }
        
        var data:Data = Data()
        
        data.append(value:
            configuration.storage.storageId)
        data.append(value:
            directory.format.rawValue)
        data.append(value:
            configuration.storage.protectionStatus)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kCompressedSize)
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
        data.append(value:parentHandle)
        data.append(value:
            configuration.directory.associationType)
        data.append(value:
            configuration.directory.associationDescr)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kSequenceNumber)
        data.append(value:dataName)
        data.append(value:
            MVitaPtpPackProtocolDefaultValues.kTerminate)
        
        self.data = data
    }
}
