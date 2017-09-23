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
            
            let responderVersion:Float = xml[
                kKeyResponderVersion] as? Float,
            let protocolVersion:String = xml[
                kKeyProtocolVersion] as? String,
            let comVersion:Int = xml[
                kKeyComVersion] as? Int,
            let modelVersion:String = xml[
                kKeyModelVersion] as? String,
            let timezone:Int = xml[
                kKeyTimezone] as? Int
        
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
            responderVersion:responderVersion,
            comVersion:comVersion,
            timezone:timezone)
        
        return infoVita
    }
    
    private static func factoryThumb(
        xml:[String:Any]) -> MVitaInfoThumb?
    {
        guard
        
            let thumbType:Int = xml[
                kKeyThumbThumbType] as? Int,
            let codecType:Int = xml[
                kKeyThumbCodecType] as? Int,
            let width:Int = xml[
                kKeyThumbWidth] as? Int,
            let height:Int = xml[
                kKeyThumbHeight] as? Int
        
        else
        {
            return nil
        }
        
        let duration:Float? = xml[
            kKeyThumbDuration] as? Float
        
        let infoThumb:MVitaInfoThumb = MVitaInfoThumb(
            thumbType:thumbType,
            codecType:codecType,
            width:width,
            height:height,
            duration:duration)
        
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
