import UIKit

final class VConnectingError:View<ArchConnecting>
{
    private let kMarginHorizontal:CGFloat = 45
    
    required init(controller:CConnecting)
    {
        let stringTitle:String = String.localizedView(
            key:"VConnectingError_labelTitle")
        let attributedTitle:NSAttributedString = NSAttributedString(
            string:stringTitle,
            attributes:[
                NSAttributedStringKey.font:UIFont.medium(size:22),
                NSAttributedStringKey.foregroundColor:UIColor.white])
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(attributedTitle)
        
        if let status:MConnectingStatusError = controller.model.status as? MConnectingStatusError
        {
            let stringSubtitle:String = String.localizedView(
                key:status.errorMessage)
            
            let attributedSubtitle:NSAttributedString = NSAttributedString(
                string:stringSubtitle,
                attributes:[
                    NSAttributedStringKey.font:UIFont.regular(size:15),
                    NSAttributedStringKey.foregroundColor:UIColor(white:1, alpha:0.9)])
            
            mutableString.append(attributedSubtitle)
        }
        
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.numberOfLines = 0
        labelTitle.attributedText = mutableString
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self,
            margin:kMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}

