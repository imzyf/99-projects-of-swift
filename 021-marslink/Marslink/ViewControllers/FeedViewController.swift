//
//  FeedViewController.swift
//  Marslink
//
//  Created by  moma on 2017/11/23.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class FeedViewController: UIViewController {
    let loader = JournalEntryLoader()
    
    
    // acts as messaging system
    let pathfinder = Pathfinder()
 
    let collectionView: IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout()) 
        view.backgroundColor = UIColor.black
        return view
    }()
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        loader.loadLatest()
        view.addSubview(collectionView)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
 
}

extension FeedViewController: IGListAdapterDataSource {
    // returns an array of data objects the should show up in the collection view.
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var items: [IGListDiffable] = pathfinder.messages
        items += loader.entries as [IGListDiffable]
        return items
    }
    
    // for each data object, must return a new instance of a section controller.
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is Message {
            return MessageSectionController()
        } else {
            return JournalSectionController()
        }
    }
    
    // returns a view that should be displayed when the list is empty
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
    
    
}
