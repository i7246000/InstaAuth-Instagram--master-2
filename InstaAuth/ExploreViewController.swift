import UIKit

class ExploreViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  var user: InstagramUser!
  
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collection: UICollectionView!
    
    var photos = [Photo]()
    
    
    
    let names = ["fgnjfgh", "gf", "adasadassd", "adasdazasd"]
    
    
    
    //Initialising a Collection View and adding it to the VC's current view
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    

    @IBAction func search(_ sender: Any) {
        makeRequest(tag: searchField.text!)
    }

    
    // Tag function, this replaces entered text in a textField into a url link, also replacing the user token.
    func makeRequest(tag: String) {
    
        let url = URL(string: "https://api.instagram.com/v1/tags/\(tag)/media/recent?access_token=\(user.token)")
        
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            
            
            let items = json["data"] as! [[String : Any]]
            
            print(items)
          
            var indexPaths = [IndexPath]()
            for (index, item) in items.enumerated() {
                let newPhoto = Photo(data: item)
                self.photos.append(newPhoto)
                indexPaths.append(IndexPath(row: index, section: 0))
            }
          
            self.display()
            
            
        }
        
        task.resume()
        
    }
    
    
    func display() {
        //let photo = self.photos.first!
        // imageView.imageFromServerURL(urlString: photo.imageUrl)
      
      collection.reloadData()
      
    }
    
    // Specifiying the number of Cells in this given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    

    // Specifying the number of sections in this Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
    
    
}
