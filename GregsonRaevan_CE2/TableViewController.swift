//
//  TableViewController.swift
//  GregsonRaevan_CE2
//
//  Created by Raevan Gregson on 11/29/16.
//  Copyright © 2016 Raevan Gregson. All rights reserved.
//

import UIKit

private let cellIdentifier = "Cell"
private let headerIdentifier = "Header"

//dataholders - two arrays to hold the hardcoded data, one bool for testing whether add or delete button is clicked and one int holder to distinguish which section the button is pushed in as to only allow those ones to be editable
var rockArtist:[Artist] = []
var popArtist:[Artist] = []
var addDelete = true
var tagHolder = 0


let alertController = UIAlertController(title: "Warning", message: "You are about to delete a row, continue?", preferredStyle: .alert)

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // I have two sections of data so I load hardcoded data into two seperate arrays. These are arrays of the class which is the blueprint for the data in general
        let micheal = Artist(name:"Micheal Jackson", genre:"Pop", albums:10, image: #imageLiteral(resourceName: "MichealJackson"))
        let britney = Artist(name: "Britney Spears", genre:"Pop",albums: 4, image: #imageLiteral(resourceName: "BrittneySpears"))
        let justin = Artist(name: "Justin Timberlake", genre:"Pop",albums: 5, image: #imageLiteral(resourceName: "JustinTimberlake"))
        let katy = Artist(name:"Katy Perry", genre: "Pop",albums: 6, image: #imageLiteral(resourceName: "KatyPerry"))
        let bruno = Artist(name: "Bruno Mars", genre: "Pop",albums: 7, image: #imageLiteral(resourceName: "BrunoMars"))
        
        popArtist = [micheal, britney, justin, katy, bruno]
        
        let kurt = Artist(name:"Kurt Cobain", genre:"Rock", albums:5, image: #imageLiteral(resourceName: "KurtCobain"))
        let redHot = Artist(name: "Red Hot Chili Peppers", genre:"Rock",albums: 4, image: #imageLiteral(resourceName: "RedHotChiliPeppers"))
        let audioSlave = Artist(name: "Audioslave", genre:"Rock",albums: 6, image: #imageLiteral(resourceName: "Audioslave"))
        let kid = Artist(name:"Kid Rock", genre: "Rock",albums: 2, image: #imageLiteral(resourceName: "KidRock"))
        let doors = Artist(name: "3 Doors Down", genre: "Rock",albums: 3, image: #imageLiteral(resourceName: "3DoorsDown"))
        
        rockArtist = [kurt, redHot, audioSlave, kid, doors]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //I distinguish how many rows should be in each section by counting the values in each array, making sure to establish a unique array per section
        var numRows = 0
        if section == 00{
        numRows = rockArtist.count
        }
        else{
        numRows = popArtist.count
        }
        return numRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell

        // Configure the cell by using the data from each object in the array by section
        
        if indexPath.section == 00{
            cell.artistLabel.text = rockArtist[indexPath.row].name
            cell.artistImage.image = rockArtist[indexPath.row].image
            cell.albumLabel.text = String(describing: rockArtist[indexPath.row].albums!)
            cell.backgroundColor = UIColor.purple.withAlphaComponent(0.10)
        }
        
        if indexPath.section == 01{
            cell.artistLabel.text = popArtist[indexPath.row].name
            cell.artistImage.image = popArtist[indexPath.row].image
            cell.albumLabel.text = String(describing: popArtist[indexPath.row].albums!)
            cell.backgroundColor = UIColor.cyan.withAlphaComponent(0.10)
        }


        return cell
    }
    
    //size the height of the custom headers
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier ) as! CustomHeader
        
        //configure header, making sure to set tags of the button depending on the section they are in, for later when I need to distinguish which section is editable
        if section == 00{
        header.button1.tag = 0
        header.button2.tag = 0
        header.header.text = "Rock"
        }
        else {
        header.button1.tag = 1
        header.button2.tag = 1
        header.header.text = "Pop"
        }
        return header
    }

    
    @IBAction func addOrDelete(sender: UIButton){
        
        //use a bool to distinguish whether the uistyle is to add or delete then set editing to true
        if sender.titleLabel!.text == "+"{
        addDelete = false
        }
        else{
        addDelete = true
        }
        tagHolder = sender.tag
        tableView.setEditing(true, animated: true)
        
     }
    


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // use an if statement to distinguish between the uistyle, whether we are deleting or adding
        if editingStyle == .delete{
            //then distinguish between sections
            if indexPath.section == 00{
                //create the UIalertcontroller and the two actions yes or no, with the code to delete the row inside of the yes action, and code that does nothing and exits editing mode if no is pressed. Then I make sure to turn editing mode off if yes is pressed after removing the row.
                let alertController = UIAlertController(title: "Warning", message: "Your about to delete a row, continue?" , preferredStyle: .alert)
                let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default){ _ in
                tableView.beginUpdates()
                rockArtist.remove(at: indexPath.row)
                tableView.deleteRows(at:[indexPath], with: .fade)
                tableView.endUpdates()
                tableView.setEditing(false, animated: true)
                }
                let no = UIAlertAction(title: "No", style: UIAlertActionStyle.default){_ in
                tableView.setEditing(false, animated: true)
                }
                alertController.addAction(yes)
                alertController.addAction(no)
                present(alertController, animated: true, completion: nil)
            }
            else if indexPath.section == 01{
                let alertController = UIAlertController(title: "Warning", message: "Your about to delete a row, continue?" , preferredStyle: .alert)
                let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default){ _ in
                    tableView.beginUpdates()
                    popArtist.remove(at: indexPath.row)
                    tableView.deleteRows(at:[indexPath], with: .fade)
                    tableView.endUpdates()
                    tableView.setEditing(false, animated: true)
                }
                let no = UIAlertAction(title: "No", style: UIAlertActionStyle.default){_ in
                    tableView.setEditing(false, animated: true)
                }
                alertController.addAction(yes)
                alertController.addAction(no)
                present(alertController, animated: true, completion: nil)
            }
        }
            //after checking for insert as the editing style I then use my newdefaultartist function to add a default artist to the corresponding array, afterwhich I then insert table rows at the end of the section, when that is finished I turn off editing.
            else if editingStyle == .insert{
                if indexPath.section == 00{
                    tableView.beginUpdates()
                    newDefaultArtist(sectionChosen: indexPath)
                    tableView.insertRows(at: [
                        NSIndexPath.init(row: rockArtist.count-1, section: 0) as IndexPath], with: .left)
                    tableView.endUpdates()
                    tableView.setEditing(false, animated: true)
                }
                else if indexPath.section == 01{
                    tableView.beginUpdates()
                    newDefaultArtist(sectionChosen: indexPath)
                    tableView.insertRows(at: [
                    NSIndexPath.init(row: popArtist.count-1, section: 1) as IndexPath], with: .left)
                    tableView.endUpdates()
                    tableView.setEditing(false, animated: true)
                }
        }
    
    }

    func newDefaultArtist(sectionChosen:IndexPath){
                // this is the function I use to create a default artist in the array depending on the indexpath given in the parameters
        if sectionChosen.section == 00 {
            let defaultArtist = Artist(name:"Default",genre:"Rock", albums: 1, image:#imageLiteral(resourceName: "default"))
            rockArtist.append(defaultArtist)
        }
        else if sectionChosen.section == 01{
            let defaultArtist = Artist(name:"Default",genre:"Pop", albums: 1, image:#imageLiteral(resourceName: "default"))
            popArtist.append(defaultArtist)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        //this is where whether the insert ui style or delete uistyle is distinguished using the bool variable I set up that is assigned with the button action
        if addDelete == false{
            return UITableViewCellEditingStyle.insert
        }
        else{
            return UITableViewCellEditingStyle.delete
        }
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        //this lets me only make the particular section I want editable at a time using the tagholder var I set up. It is set equal to the section when I configure the custom headers
        
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == tagHolder{
            return true
        }
        else{
            return false
        }
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
