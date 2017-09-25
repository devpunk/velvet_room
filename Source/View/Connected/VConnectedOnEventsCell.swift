import UIKit

class VConnectedOnEventsCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let options:NSStringDrawingOptions
    private let boundingSize:CGSize
    private let kMaxTextHeight:CGFloat = 1000
    
    override init(frame:CGRect)
    {
        let width:CGFloat = frame.width
        options = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        boundingSize = CGSize(
            width:width,
            height:kMaxTextHeight)
        
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        isUserInteractionEnabled = false
        
        let labelTop:CGFloat = width
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:labelTop)
        layoutLabelHeight = NSLayoutConstraint.height(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func config(model:MConnectedEventProtocol)
    {
    }
    
    final func configText(string:NSAttributedString)
    {
        label.attributedText = string
        
        let stringRect:CGRect = string.boundingRect(
            with:boundingSize,
            options:options,
            context:nil)
        let stringHeight:CGFloat = ceil(stringRect.height)
        layoutLabelHeight.constant = stringHeight
    }
}
