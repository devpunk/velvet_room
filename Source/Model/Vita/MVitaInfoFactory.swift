import Foundation

extension MVitaInfo
{    
    //MARK: private
    
    private static func factoryInfoVita(
        xml:[String:Any],
        infoGame:MVitaInfoThumb,
        infoPhoto:MVitaInfoThumb,
        infoVideo:MVitaInfoThumb,
        infoMusic:MVitaInfoThumb) -> MVitaInfo?
    {
        guard
            
            let responderVersion:String = xml[
                kKeyResponderVersion] as? String,
            let responderVersionFloat:Float = Float(responderVersion),
            let protocolVersion:String = xml[
                kKeyProtocolVersion] as? String,
            let comVersion:String = xml[
                kKeyComVersion] as? String,
            let comVersionInt:Int = Int(comVersion),
            let modelVersion:String = xml[
                kKeyModelVersion] as? String,
            let timezone:String = xml[
                kKeyTimezone] as? String,
            let timezoneInt:Int = Int(timezone)
        
        else
        {
            return nil
        }
        
        let infoVita:MVitaInfo = MVitaInfo(
            infoGame:infoGame,
            infoPhoto:infoPhoto,
            infoVideo:infoVideo,
            infoMusic:infoMusic,
            protocolVersion:protocolVersion,
            modelVersion:modelVersion,
            responderVersion:responderVersionFloat,
            comVersion:comVersionInt,
            timezone:timezoneInt)
        
        return infoVita
    }
    
    private static func factoryThumb(
        xml:[String:Any]) -> MVitaInfoThumb?
    {
        guard
        
            let thumbType:String = xml[
                kKeyThumbThumbType] as? String,
            let thumbTypeInt:Int = Int(thumbType),
            let codecType:String = xml[
                kKeyThumbCodecType] as? String,
            let codecTypeInt:Int = Int(codecType),
            let width:String = xml[
                kKeyThumbWidth] as? String,
            let widthInt:Int = Int(width),
            let height:String = xml[
                kKeyThumbHeight] as? String,
            let heightInt:Int = Int(height)
        
        else
        {
            return nil
        }
        
        let duration:String? = xml[
            kKeyThumbDuration] as? String
        let durationFloat:Float?
        
        if let durationString:String = duration
        {
             durationFloat = Float(durationString)
        }
        else
        {
            durationFloat = nil
        }
        
        let infoThumb:MVitaInfoThumb = MVitaInfoThumb(
            thumbType:thumbTypeInt,
            codecType:codecTypeInt,
            width:widthInt,
            height:heightInt,
            duration:durationFloat)
        
        return infoThumb
    }
    
    //MARK: internal
    
    static func factoryInfo(xml:[String:Any]) -> MVitaInfo?
    {
        guard
        
            let rawInfoVita:[String:Any] = xml[
                kKeyInfoVita] as? [String:Any],
            let rawInfoGame:[String:Any] = rawInfoVita[
                kKeyInfoGame] as? [String:Any],
            let rawInfoPhoto:[String:Any] = rawInfoVita[
                kKeyInfoPhoto] as? [String:Any],
            let rawInfoVideo:[String:Any] = rawInfoVita[
                kKeyInfoVideo] as? [String:Any],
            let rawInfoMusic:[String:Any] = rawInfoVita[
                kKeyInfoMusic] as? [String:Any],
            let infoGame:MVitaInfoThumb = factoryThumb(
                xml:rawInfoGame),
            let infoPhoto:MVitaInfoThumb = factoryThumb(
                xml:rawInfoPhoto),
            let infoVideo:MVitaInfoThumb = factoryThumb(
                xml:rawInfoVideo),
            let infoMusic:MVitaInfoThumb = factoryThumb(
                xml:rawInfoMusic),
            let infoVita:MVitaInfo = factoryInfoVita(
                xml:rawInfoVita,
                infoGame:infoGame,
                infoPhoto:infoPhoto,
                infoVideo:infoVideo,
                infoMusic:infoMusic)
        
        else
        {
            return nil
        }
        
        return infoVita
    }
}
