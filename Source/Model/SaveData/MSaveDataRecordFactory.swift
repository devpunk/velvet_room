import UIKit

extension MSaveDataRecord
{
    private static let kNewLine:String = "\n"
    private static let kTitleFontSize:CGFloat = 16
    private static let kDescrFontSize:CGFloat = 14
    private static let kDateFontSize:CGFloat = 12
    
    //MARK: private
    
    private static func factoryTitle(
        coredataModel:DVitaItemDirectory,
        attributesTitle:[NSAttributedStringKey:Any]) -> NSAttributedString?
    {
        guard
        
            let title:String = coredataModel.sfoSavedDataTitle
        
        else
        {
            return nil
        }
        
        let attributedString:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributesTitle)
        
        return attributedString
    }
    
    private static func factoryNewLine() -> NSAttributedString
    {
        let attributedString:NSAttributedString = NSAttributedString(
            string:kNewLine)
        
        return attributedString
    }
    
    private static func factoryDescr(
        coredataModel:DVitaItemDirectory,
        attributesDescr:[NSAttributedStringKey:Any]) -> NSAttributedString?
    {
        guard
            
            let descr:String = coredataModel.sfoSavedDataDetail
            
        else
        {
            return nil
        }
        
        let attributedString:NSAttributedString = NSAttributedString(
            string:descr,
            attributes:attributesDescr)
        
        return attributedString
    }
    
    private static func factoryDate(
        coredataModel:DVitaItemDirectory,
        dateFormater:DateFormatter,
        attributesDate:[NSAttributedStringKey:Any]) -> NSAttributedString
    {
        let date:Date = Date(timeIntervalSince1970:coredataModel.dateModified)
        let string:String = dateFormater.string(from:date)
        
        let attributedString:NSAttributedString = NSAttributedString(
            string:string,
            attributes:attributesDate)
        
        return attributedString
    }
    
    //MARK: internal
    
    static func factoryDateFormatter() -> DateFormatter
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        return dateFormatter
    }
    
    static func factoryAttributesTitle() -> [NSAttributedStringKey:Any]
    {
        let attributes:[NSAttributedStringKey:Any] = [
            NSAttributedStringKey.font:
                UIFont.regular(size:kTitleFontSize),
            NSAttributedStringKey.foregroundColor:
                UIColor.colourBackgroundDark]
        
        return attributes
    }
    
    static func factoryRecord(
        coredataModel:DVitaItemDirectory,
        dateFormatter:DateFormatter,
        attributesTitle:[NSAttributedStringKey:Any],
        attributesDescr:[NSAttributedStringKey:Any],
        attributesDate:[NSAttributedStringKey:Any]) -> MSaveDataRecord?
    {
        guard
        
            let title:NSAttributedString = factoryTitle(
                coredataModel:coredataModel,
                attributesTitle:attributesTitle)
        
        else
        {
            return nil
        }
        
        let date:NSAttributedString = factoryDate(
            coredataModel:coredataModel,
            dateFormater:dateFormatter,
            attributesDate:attributesDate)
        let newLine:NSAttributedString = factoryNewLine()
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(title)
        
        if let descr:NSAttributedString = factoryDescr(
            coredataModel:coredataModel,
            attributesDescr:attributesDescr)
        {
            mutableString.append(newLine)
            mutableString.append(descr)
        }
        
        mutableString.append(newLine)
        mutableString.append(date)
        
        let record:MSaveDataRecord = MSaveDataRecord(
            record:mutableString)
        
        return record
    }
}
