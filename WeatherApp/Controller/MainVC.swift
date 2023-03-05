import UIKit
import SDWebImage

class MainVC: UIViewController {
    
    @IBOutlet weak var currentLbl: UILabel!
    
    @IBOutlet weak var currentIcon: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HourlyTemperatures", bundle: nil), forCellReuseIdentifier: "HourlyTemperatures")
        }
    }
    
    @IBOutlet weak var search: UISearchBar!
        
    @IBOutlet weak var getWeatherBtn: UIButton!
    
    @IBOutlet weak var textForCurrent: UILabel!
    
    var times = [String]()
    var temps = [String]()
    var timesCopy = [String]()
    var data: WeatherDM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self
        getWeatherBtn.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        textForCurrent.text = "Search your citi..."
        currentLbl.text = ""
        currentIcon.isHidden = true
    }
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        
        search.text = data.regionName
        currentLbl.text = data.currentTemp
        times = data.timeForHours
        temps = data.timeTemp
        currentLbl.text = "\(data.currentTemp)Cº"
        textForCurrent.text = "Current weather: "
        currentIcon.isHidden = false
        setUpIcon(degree: Double(data.currentTemp) ?? 9.0)
        tableView.reloadData()
    }
    
    func setUpIcon(degree: Double){
        
        if degree > 10 {
            currentIcon.image = UIImage(systemName: "sun.max")
        } else if degree < 0 {
            currentIcon.image = UIImage(systemName: "cloud.rain")
        } else {
            currentIcon.image = UIImage(systemName: "cloud.sun")
        }
    }
    
}

extension MainVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTemperatures", for: indexPath) as? HourlyTemperatures else { return UITableViewCell() }
        cell.updateCell(time: times[indexPath.row], temp: temps[indexPath.row])
        return cell
    }
    
}


extension MainVC: UISearchBarDelegate {
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
          API.getInfo(q: "\(searchText)", key: "fc97f9cc2eb64deab2b153445230902") { [self] data in
             
              if !data!.regionName.isEmpty {
                  
                  var isCountry = true

                  for i in data!.regionName {
                      if i == " " {
                          isCountry = false
                      }
                  }
                  
                  if isCountry {
                      
                      self.data = data
                      getWeatherBtn.isHidden = false
                      getWeatherBtn.setTitle(data?.regionName, for: .normal)
                      
                  } else {
                      // not country
                      getWeatherBtn.isHidden = true
                      times = [String]()
                      currentLbl.text = ""
                      textForCurrent.text = "Search your citi..."
                      currentIcon.isHidden = true
                      tableView.reloadData()
                  }
                
              }
              tableView.reloadData()
          }
        
    }

    
}


