//
//  TablePaginatedBaseViewController.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import UIKit

class TablePaginatedBaseViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tblView: UITableView!

    var elementsByPage = 20
    
    var paginationIsActive: Bool = false
    var checkPointForNextRead: CGFloat = 0.0
    var heightToCalculateCheckPoint: CGFloat = 0.0

    var elements: [Any] = [Any]()
    
    var reuseIdentifier: String!

    let feedPagination = FeedPagination()
    var offsetForCheckPoint: CGFloat = 0.0
    var footerTableWaitResponse: FooterWaitPageView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        feedPagination.elementsByPage = self.elementsByPage
        
        self.tblView.dataSource = self
        self.tblView.delegate = self

        configTablePaginatedVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        footerTableWaitResponse=FooterWaitPageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 24.0))
        footerTableWaitResponse.spinner.color=Konstants.kColor_BlueMarvel;

    }
    
    // MARK: Methods
    
    func configTablePaginatedVC(){
        //To override by each subclass
        self.reuseIdentifier = ""
    }
    
    func launchDataRequest(){
        //Used when request the first page
        paginationIsActive = false;
        checkPointForNextRead = 0.0;
        self.feedPagination.resetFeedPagination()
    }

    func launchNextPageRequest() {
        //To override by each subclass
        
        self.tblView.tableFooterView = footerTableWaitResponse
        footerTableWaitResponse.startAnimating()
    }

    func updateFeedPagination(responseObject: Any) {
        //To override by each subclass/project
        
        //The override must call processPagination at the end
        //processPagination()
    }
    
    func processPagination(){
        
        self.tblView.tableFooterView = nil
        
        self.elements = self.feedPagination.accumulatedElements

        if self.feedPagination.lastPageReadIt == 1{
            
            if self.elements.count != 0 {
                
                paginationIsActive = !self.feedPagination.alreadyReadedAllElements()
                
                //This before reload and scrollToRowAtIndexPath to have and update value of checkPointForNextRead when do the check on
                if paginationIsActive {
                    //Set the next check point to the begin of second page
                    checkPointForNextRead = checkPointForNextRead+self.offsetForCheckPoint+heightToCalculateCheckPoint*CGFloat(self.feedPagination.elementsByPage)
                }
                
                //This after update checkPointForNextRead
                self.tblView.reloadData()
                self.tblView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                
                //This at the end, to launch new request when the reload was done
                if (paginationIsActive) {
                    //Si hay paginación, lanza inmediatamente la petición de la segunda página
                    launchNextPageRequest()
                }
            }
            
        }else{

            //To finish the pagination we use the number of elements received, not the value of feedPaginadoBusqueda.leidosTodosLosElementos. If the numeroElementosUltimaLectura==0 then finish, if not, load data and verify leidosTodosLosElementos to know if we continue or not
            if self.feedPagination.lastFetchElements.count > 0 {
                
//                LogIfDebugSA(@"hace insercion count acumulados %ld elements %ld, ultima lectura %ld", (long)[self.feedPaginado.arrayAcumulados count], (long)[self.arrayElements count], (long)[self.feedPaginado.arrayUltimaLectura count]);

                let iBase = self.feedPagination.accumulatedElements.count - self.feedPagination.lastFetchElements.count
                var indexsPaths = [IndexPath]()
                for i in iBase...self.feedPagination.accumulatedElements.count-1 {
                    let index = IndexPath(row: i, section: 0)
                    indexsPaths.append(index)
                }
                
                self.tblView.insertRows(at: indexsPaths, with: .none)
                
                if self.feedPagination.alreadyReadedAllElements() {
                    paginationIsActive = false
                    //the next check point was already updated in teh scroll delegate
                }
                
            }else{
                paginationIsActive = false
            }
        }
    }
    
    func stopPaginationByError(){
        self.tblView.tableFooterView=nil;
        paginationIsActive = false
    }
    
    func tableViewSelect(item: Any, atIndexPath: IndexPath){
        //To override by each subclass
    }
    
}

extension TablePaginatedBaseViewController {
     
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BaseCell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath as IndexPath) as! BaseCell
        
        let info = elements[indexPath.row]
        cell.setupCell(info: info)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row >= 0 && indexPath.row < self.elements.count {
            tableViewSelect(item: self.elements[indexPath.row], atIndexPath: indexPath)
        }
    }
    
    // MARK: - UIScrollViewDelegate
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if paginationIsActive {
            if self.tblView.contentOffset.y > (checkPointForNextRead - self.tblView.frame.size.height) {
                //Here don't add self.offsetForCheckPoint to avoid add it again
                checkPointForNextRead = checkPointForNextRead + heightToCalculateCheckPoint * CGFloat(self.feedPagination.elementsByPage)
                launchNextPageRequest()
            }
        }
    }
}
