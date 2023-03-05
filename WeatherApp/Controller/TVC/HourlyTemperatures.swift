import UIKit

class HourlyTemperatures: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var temptLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCell(time: String, temp: String){
        timeLbl.text = time
        temptLbl.text = "\(temp)Cº"
    }
    
}
