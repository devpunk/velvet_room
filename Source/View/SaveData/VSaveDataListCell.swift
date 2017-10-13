import UIKit

class VSaveDataListCell:UICollectionViewCell
{
    private(set) weak var controller:CSaveData?
    private let kBorderMargin:CGFloat = 10
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let border:VBorder = VBorder(
            colour:UIColor.colourBackgroundGray)
        
        addSubview(border)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self,
            margin:kBorderMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func config(
        controller:CSaveData,
        model:MSaveDataProtocol)
    {
        self.controller = controller
    }
}
