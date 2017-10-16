import Foundation

extension MVitaItemInExtension
{
    private static let kDot:String = "."
    
    //MARK: private
    
    private static func rawExtension(
        name:String) -> String?
    {
        let components:[String] = name.components(
            separatedBy:kDot)
        
        var lastComponent:String? = components.last
        lastComponent = lastComponent?.lowercased()
        
        return lastComponent
    }
    
    //MARK: internal
    
    static func factoryExtension(
        name:String) -> MVitaItemInExtension
    {
        guard
        
            let raw:String = rawExtension(
                name:name),
            let fileExtension:MVitaItemInExtension = MVitaItemInExtension(
                rawValue:raw)
        
        else
        {
            return MVitaItemInExtension.unknown
        }
        
        return fileExtension
    }
}
