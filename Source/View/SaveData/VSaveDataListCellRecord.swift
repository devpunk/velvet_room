import UIKit

final class VSaveDataListCellRecord:VSaveDataListCell
{
    private weak var label:UILabel!
    private let kMarginRight:CGFloat = -10
    private let kMarginLeft:CGFloat = 30
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self,
            constant:kMarginLeft)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kMarginRight)
        
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:label)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(
        controller:CSaveData,
        model:MSaveDataProtocol)
    {
        super.config(
            controller:controller,
            model:model)
        
        guard
            
            let itemRecord:MSaveDataRecord = model as? MSaveDataRecord
            
        else
        {
            return
        }
        
        label.attributedText = itemRecord.record
    }
}
