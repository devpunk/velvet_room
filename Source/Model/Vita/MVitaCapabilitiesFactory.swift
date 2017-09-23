import Foundation

extension MVitaCapabilities
{
    //MARK: private
    
    private static func factoryFunctions(
        xml:[Any]) -> [MVitaCapabilitiesFunction]
    {
        var functions:[MVitaCapabilitiesFunction] = []
        
        for item:Any in xml
        {
            guard
            
                let rawFunction:[String:Any] = item as? [String:Any],
                let function:MVitaCapabilitiesFunction = factoryFunction(
                    xml:rawFunction)
            
            else
            {
                continue
            }
            
            functions.append(function)
        }
        
        return functions
    }
    
    private static func factoryFunction(
        xml:[String:Any]) -> MVitaCapabilitiesFunction?
    {
        guard
            
            let functionType:String = xml[kKeyFunctionType] as? String
        
        else
        {
            return nil
        }
        
        let interface:Int? = factoryInterface(xml:xml)
        let options:[MVitaCapabilitiesFunctionOption] = factoryOptions(
            xml:xml)
        let formats:[MVitaCapabilitiesFunctionFormat] = factoryFormats(
            xml:xml)
        
        let function:MVitaCapabilitiesFunction = MVitaCapabilitiesFunction(
            formats:formats,
            options:options,
            functionType:functionType,
            interface:interface)
        
        return function
    }
    
    private static func factoryInterface(
        xml:[String:Any]) -> Int?
    {
        guard
            
            let rawInterface:String = xml[kKeyFunctionInterface] as? String
            
        else
        {
            return nil
        }
        
        let interface:Int? = Int(rawInterface)
        
        return interface
    }
    
    private static func factoryOptions(
        xml:[String:Any]) -> [MVitaCapabilitiesFunctionOption]
    {
        var options:[MVitaCapabilitiesFunctionOption] = []
        
        guard
        
            let rawOptions:[Any] = xml[kKeyFunctionOption] as? [Any]
        
        else
        {
            return options
        }
        
        for rawOption:Any in rawOptions
        {
            guard
            
                let option:MVitaCapabilitiesFunctionOption = factoryOption(
                    xml:rawOption)
            
            else
            {
                continue
            }
            
            options.append(option)
        }
        
        return options
    }
    
    private static func factoryOption(
        xml:Any) -> MVitaCapabilitiesFunctionOption?
    {
        guard
        
            let dictionary:[String:Any] = xml as? [String:Any],
            let name:String = dictionary[kKeyFunctionOptionName] as? String,
            let option:MVitaCapabilitiesFunctionOption = MVitaCapabilitiesFunctionOption(
                rawValue:name)
        
        else
        {
            return nil
        }
        
        return option
    }
    
    private static func factoryFormats(
        xml:[String:Any]) -> [MVitaCapabilitiesFunctionFormat]
    {
        var formats:[MVitaCapabilitiesFunctionFormat] = []
        
        guard
            
            let rawFormats:[Any] = xml[kKeyFunctionFormat] as? [Any]
            
        else
        {
            return formats
        }
        
        for rawFormat:Any in rawFormats
        {
            guard
                
                let format:MVitaCapabilitiesFunctionFormat = factoryFormat(
                    xml:rawFormat)
                
            else
            {
                continue
            }
            
            formats.append(format)
        }
        
        return formats
    }
    
    private static func factoryFormat(
        xml:Any) -> MVitaCapabilitiesFunctionFormat?
    {
        guard
            
            let dictionary:[String:Any] = xml as? [String:Any]
        
        else
        {
            return nil
        }
        
        let formatType:String? = dictionary[kKeyFunctionFormatType] as? String
        let contentType:String? = dictionary[kKeyFunctionFormatContentType] as? String
        let codec:String? = dictionary[kKeyFunctionFormatCodec] as? String
        let codecAudio:String? = dictionary[kKeyFunctionFormatCodecAudio] as? String
        let codecVideo:String? = dictionary[kKeyFunctionFormatCodecVideo] as? String
        
        let format:MVitaCapabilitiesFunctionFormat = MVitaCapabilitiesFunctionFormat(
            formatType:formatType,
            contentType:contentType,
            codec:codec,
            codecAudio:codecAudio,
            codecVideo:codecVideo)
        
        return format
    }
    
    //MARK: internal
    
    static func factoryCapabilities(
        xml:[String:Any]) -> MVitaCapabilities?
    {
        guard
        
            let rawCapabilities:[String:Any] = xml[kKeyCapabilities] as? [String:Any],
            let rawFunctions:[Any] = rawCapabilities[kKeyFunction] as? [Any],
            let rawVersion:String = rawCapabilities[kKeyVersion] as? String,
            let version:Float = Float(rawVersion)
        
        else
        {
            return nil
        }
        
        let functions:[MVitaCapabilitiesFunction] = factoryFunctions(
            xml:rawFunctions)
        let capabilities:MVitaCapabilities = MVitaCapabilities(
            functions:functions,
            version:version)
        
        return capabilities
    }
}
