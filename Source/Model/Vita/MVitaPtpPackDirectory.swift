import Foundation

struct MVitaPtpPackDirectory:MVitaPtpPackProtocol
{
    let data:Data
    private let kCompressedSize:UInt32 = 0
    private let kThumbFormat:UInt32 = 0
    private let kThumbCompressedSize:UInt32 = 0
    private let kThumbWith:UInt32 = 0
    private let kThumbHeight:UInt32 = 0
    private let kImageWith:UInt32 = 0
    private let kImageHeight:UInt32 = 0
    private let kImageBitDepth:UInt32 = 0
    private let kAssociationType:UInt16 = 1
    private let kAssociationDescr:UInt32 = 56326
    private let kSequenceNumber:UInt32 = 0
    private let kTerminate:UInt16 = 0
    
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
        
        data.append(value:configuration.storage.storageId)
        data.append(value:directory.format.rawValue)
        data.append(value:configuration.storage.protectionStatus)
        data.append(value:kCompressedSize)
        data.append(value:kThumbFormat)
        data.append(value:kThumbCompressedSize)
        data.append(value:kThumbWith)
        data.append(value:kThumbHeight)
        data.append(value:kImageWith)
        data.append(value:kImageHeight)
        data.append(value:kImageBitDepth)
        data.append(value:parentHandle)
        data.append(value:kAssociationType)
        data.append(value:kAssociationDescr)
        data.append(value:kSequenceNumber)
        data.append(value:dataName)
        data.append(value:kTerminate)
        
        self.data = data
    }
}
