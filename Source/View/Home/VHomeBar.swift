import UIKit

final class VHomeBar:View<ArchHome>
{
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.white
        
        let border:VBorder = VBorder(
            colour:UIColor.colourBackgroundDark)
        
        addSubview(border)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
