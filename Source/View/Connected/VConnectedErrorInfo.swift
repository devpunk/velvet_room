import UIKit

final class VConnectedErrorInfo:View<ArchConnected>
{
    private let kMarginHorizontal:CGFloat = 45
    
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func factoryViews()
    {
        guard
            
            let message:NSAttributedString = factoryMessage()
            
        else
        {
            return
        }
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.numberOfLines = 0
        labelTitle.attributedText = message
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self,
            margin:kMarginHorizontal)
    }
    
    private func factoryMessage() -> NSAttributedString?
    {
        guard
            
            let subtitle:NSAttributedString = factorySubtitle()
            
        else
        {
            return nil
        }
        
        let title:NSAttributedString = factoryTitle()
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(title)
        mutableString.append(subtitle)
        
        return mutableString
    }
    
    private func factoryTitle() -> NSAttributedString
    {
        let string:String = String.localizedView(
            key:"VConnectedErrorInfo_labelTitle")
        let attributes:[NSAttributedStringKey:Any] = [
            NSAttributedStringKey.font:
                UIFont.bold(size:22),
            NSAttributedStringKey.foregroundColor:
                UIColor.colourFail]
        let attributed:NSAttributedString = NSAttributedString(
            string:string,
            attributes:attributes)
        
        return attributed
    }
    
    private func factorySubtitle() -> NSAttributedString?
    {
        guard
            
            let status:MConnectedStatusError = controller.model.status as? MConnectedStatusError
            
        else
        {
            return nil
        }
        
        let string:String = String.localizedView(
            key:status.errorMessage)
        let attributes:[NSAttributedStringKey:Any] = [
            NSAttributedStringKey.font:
                UIFont.regular(size:15),
            NSAttributedStringKey.foregroundColor:
                UIColor(white:0.4, alpha:1)]
        let attributed:NSAttributedString = NSAttributedString(
            string:string,
            attributes:attributes)
        
        return attributed
    }
}
