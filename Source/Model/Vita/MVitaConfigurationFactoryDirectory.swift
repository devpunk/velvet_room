import Foundation

extension MVitaConfiguration
{
    //MARK: internal
    
    static func factoryConfigurationDirectory(
        map:[String:Any]) -> MVitaConfigurationDirectory?
    {
        guard
            
            let mapDirectory:[String:Any] = map[
                kKeyDirectory] as? [String:Any],
            let associationType:UInt16 = mapDirectory[
                kKeyDirectoryAssociationType] as? UInt16,
            let associationDescr:UInt32 = mapDirectory[
                kKeyDirectoryAssociationDescr] as? UInt32
            
        else
        {
            return nil
        }
        
        let directory:MVitaConfigurationDirectory = MVitaConfigurationDirectory(
            associationType:associationType,
            associationDescr:associationDescr)
        
        return directory
    }
}
