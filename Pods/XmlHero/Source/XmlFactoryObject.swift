import Foundation

extension Xml
{
    //MARK: internal
    
    class func asyncObject(
        xml:Xml,
        data:Data,
        completion:@escaping(([String:Any]?, XmlError?) -> ()))
    {
        let dataCleaned:Data = cleanData(data:data)
        
        xml.parse(
            data:dataCleaned,
            completion:completion)
    }
    
    //MARK: open
    
    @discardableResult open class func object(
        data:Data,
        completion:@escaping(([String:Any]?, XmlError?) -> ())) -> Xml
    {
        let xml:Xml = Xml()
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        {
            asyncObject(
                xml:xml,
                data:data,
                completion:completion)
        }
        
        return xml
    }
}
