import UIKit

final class VConnectingPin:View<ArchConnecting>
{
    private let kTitleHeight:CGFloat = 90
    private let kListHeight:CGFloat = 50
    private let kListTop:CGFloat = 250
    
    required init(controller:CConnecting)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let viewList:VConnectingPinList = VConnectingPinList(
            controller:controller)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:16)
        labelTitle.textColor = UIColor.white
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = String.localizedView(
            key:"VConnectingPin_labelTitle")
        
        addSubview(viewList)
        addSubview(labelTitle)
        
        NSLayoutConstraint.topToTop(
            view:viewList,
            toView:self,
            constant:kListTop)
        NSLayoutConstraint.height(
            view:viewList,
            constant:kListHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewList,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:labelTitle,
            toView:viewList)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
