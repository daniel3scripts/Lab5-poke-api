
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let pokeViewModel: PokeViewModel = PokeViewModel()
    
    // Creando un array del filtro
    var filterData: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await setUpData()
        }
        setUpView()
    }
    
    func setUpView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragInteractionEnabled = true
        searchBar.delegate = self
    }
    
    func setUpData() async {
        await pokeViewModel.getDataFromAPI()
        filterData = pokeViewModel.pokemons
    
        // refresh
        tableView.reloadData()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = filterData[indexPath.row].name.capitalized
        cell.imageView?.image = HelperImage.setImage(id: HelperString.getIdFromUrl(url: filterData[indexPath.row].url))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(HelperString.getIdFromUrl(url: pokeViewModel.pokemons[indexPath.row].url))
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(pokeViewModel.pokemons[sourceIndexPath.row].name)
    }
}

// Extension para SearchBar
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty
        ? pokeViewModel.pokemons
        : pokeViewModel.pokemons.filter({ (item: Result) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        // para que despues de la busqueda la table se reinicie
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
