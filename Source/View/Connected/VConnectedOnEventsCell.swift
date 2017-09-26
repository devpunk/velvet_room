import UIKit

class VConnectedOnEventsCell:UICollectionViewCell
{
    let lineBreak:NSAttributedString
    let attributesTimestamp:[NSAttributedStringKey:Any]
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let options:NSStringDrawingOptions
    private let boundingSize:CGSize
    private let kLineBreak:String = "\n"
    private let kMaxTextHeight:CGFloat = 1000
    private let kLabelTop:CGFloat = 10
    private let kTimestampFontSize:CGFloat = 13
    
    override init(frame:CGRect)
    {
        attributesTimestamp = [
            NSAttributedStringKey.foregroundColor:
                UIColor(white:0.6, alpha:1),
            NSAttributedStringKey.font:
                UIFont.regular(size:kTimestampFontSize)]
        
        lineBreak = NSAttributedString(
            string:kLineBreak)
        
        let width:CGFloat = frame.width
        let labelTop:CGFloat = width + kLabelTop
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
            view:label)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func heightForString(string:NSAttributedString) -> CGFloat
    {
        let stringRect:CGRect = string.boundingRect(
            with:boundingSize,
            options:options,
            context:nil)
        let height:CGFloat = ceil(stringRect.height)
        
        return height
    }
    
    //MARK: internal
    
    final func configText(string:NSAttributedString)
    {
        let stringHeight:CGFloat = heightForString(
            string:string)
        
        label.attributedText = string
        layoutLabelHeight.constant = stringHeight
    }
    
    func config(model:MConnectedEventProtocol) { }
}
