import UIKit

final class VConnectingPin:View<ArchConnecting>
{
    private let kTitleBottom:CGFloat = -150
    private let kTitleHeight:CGFloat = 60
    private let kListHeight:CGFloat = 70
    private let kListTop:CGFloat = 200
    
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
        labelTitle.font = UIFont.medium(size:15)
        labelTitle.textColor = UIColor.white
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.text = String.localizedView(
            key:"VConnectingPin_labelTitle")
        
        addSubview(viewList)
        addSubview(labelTitle)
        
        NSLayoutConstraint.topToTop(
            view:viewList,
            toView:self)
        NSLayoutConstraint.height(
            view:viewList,
            constant:kListHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewList,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self,
            constant:kTitleBottom)
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
