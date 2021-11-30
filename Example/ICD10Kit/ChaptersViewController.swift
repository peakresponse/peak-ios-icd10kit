//
//  ChaptersViewController.swift
//  ICD10Kit
//
//  Created by Francis Li on 11/29/2021.
//  Copyright (c) 2021 Francis Li. All rights reserved.
//

import ICD10Kit
import RealmSwift
import UIKit
import Foundation

class ChaptersViewController: UITableViewController, UIDocumentPickerDelegate, ICD10CMParserDelegate {
    var parser: ICD10CMParser?
    var results: Results<CMChapter>?
    var notificationToken: NotificationToken?

    deinit {
        notificationToken?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        performQuery()
    }

    func performQuery() {
        notificationToken?.invalidate()
        let realm = CMRealm.open()
        results = realm.objects(CMChapter.self).sorted(byKeyPath: "position", ascending: true)
        notificationToken = results?.observe { [weak self] (changes) in
            self?.didObserveRealmChanges(changes)
        }
    }

    func didObserveRealmChanges(_ changes: RealmCollectionChange<Results<CMChapter>>) {
        switch changes {
        case .initial:
            tableView.reloadData()
        case .update(_, let deletions, let insertions, let modifications):
            tableView.beginUpdates()
            tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
            tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
            tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
            tableView.endUpdates()
        case .error(let error):
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction @objc func importPressed() {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.xml"], in: .open)
        picker.delegate = self
        present(picker, animated: true)
    }

    @IBAction @objc func exportPressed() {
        
    }

    func importCodes(from url: URL) {
        for item in navigationItem.leftBarButtonItems ?? [] {
            item.isEnabled = false
        }
        for item in navigationItem.rightBarButtonItems ?? [] {
            item.isEnabled = false
        }
        var spinner: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            spinner = UIActivityIndicatorView(activityIndicatorStyle: .medium)
        } else {
            spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        }
        spinner.startAnimating()
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(customView: spinner))
        parser = ICD10CMParser(url: url)
        parser?.delegate = self
        parser?.start()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow,
           let chapter = results?[indexPath.row],
           let vc = segue.destination as? CodesViewController {
            vc.chapter = chapter
        }
    }
    
    // MARK: - ICD10CMParserDelegate
    
    func icd10CMParserDidFinish(_ parser: ICD10CMParser) {
        _ = navigationItem.leftBarButtonItems?.popLast()
    }
    
    // MARK: - UIDocumentPickerDelegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let url = urls[0]
        if url.pathExtension == "xml" {
            importCodes(from: url)
        }
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Chapter", for: indexPath)
        if let chapter = results?[indexPath.row] {
            cell.textLabel?.text = "\(chapter.name ?? ""): \(chapter.desc ?? "")"
        }
        return cell
    }
}
