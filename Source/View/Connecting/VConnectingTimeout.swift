import UIKit

final class VConnectingTimeout:View<ArchConnecting>
{
    required init(controller:CConnecting)
    {
        let stringTitle:String = String.localizedView(
            key:"VConnectingTimeout_labelTitle")
        let stringSubtitle:String = String.localizedView(
            key:"VConnectingTimeout_labelSubtitle")
        let attributedTitle:NSAttributedString = NSAttributedString(
            string:stringTitle,
            attributes:[
                NSAttributedStringKey.font:UIFont.medium(size:18),
                NSAttributedStringKey.foregroundColor:UIColor.white])
        let attributedSubtitle:NSAttributedString = NSAttributedString(
            string:stringSubtitle,
            attributes:[
                NSAttributedStringKey.font:UIFont.regular(size:15),
                NSAttributedStringKey.foregroundColor:UIColor(white:1, alpha:0.7)])
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(attributedTitle)
        mutableString.append(attributedSubtitle)
        
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
    
        NSLayoutConstraint.equals(
            view:labelTitle,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
