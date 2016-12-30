//
//  ViewController.swift
//  PokeDex
//
//  Created by Dylan wichman on 12/29/16.
//  Copyright © 2016 Bulletproof Interactive. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer = AVAudioPlayer()
    var searchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionview.delegate = self
        collectionview.dataSource = self
        searchBar.delegate = self
        parsePokemonCSV()
        initAudio()
    }

    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //continious loop
            musicPlayer.play()
        } catch {
            let err = error as NSError
            print(err)
        }
    }

    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                let pokemon = Pokemon(name: name, id: id)
                self.pokemon.append(pokemon)
            }
            
        } catch {
            let err = error as NSError
            print(err)
        }
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !searchMode {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokeCell

        cell.configureCell(pokemon[indexPath.row])
        return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokeCell
            
            cell.configureCell(filteredPokemon[indexPath.row])
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !searchMode {
        return pokemon.count
        } else {
            return filteredPokemon.count
        }
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying == true {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            searchMode = false
            collectionview.reloadData()
            
        } else {
            searchMode = true
            
            let lower = searchBar.text?.lowercased()
            // $0 is a placeholder for every item in pokemon
            filteredPokemon = pokemon.filter({$0.name.range(of: lower!) != nil})
            
            collectionview.reloadData()
        }
    }


}

