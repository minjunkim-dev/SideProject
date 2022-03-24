//
//  NewlyCoinedWordViewModel.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import Foundation

final class NewlyCoinedWordViewModel {
    
    var wordList: Observable<[NewlyCoinedWord]> = Observable([])
    
    var maxHashTagsNumber: Int = 5
    var hashTags: Observable<[NewlyCoinedWord]> = Observable([])
    
    var searchWord: Observable<NewlyCoinedWord> = Observable(NewlyCoinedWord(title: "", description: ""))
    
    func searchQuery(query: String, completion: @escaping (SearchError?) -> Void) {
        
        if wordList.value.isEmpty {
            print("신조어 리스트가 없음!")
            completion(.isEmptyWordList)
            return
        }
        
        let group = DispatchGroup()
        group.enter()
        
        let results = wordList.value.filter {
            $0.title.compare(query, options: .caseInsensitive) == .orderedSame
        }
        
        if let result = results.first {
            print("신조어 검색 성공!")
            self.searchWord.value = result
            completion(nil)
        } else {
            print("신조어 검색 실패!")
            completion(.notExistWordInList)
        }
    }
    
    func searchWords(query: String, completion: @escaping () -> Void) {
        
        let maxDisplay = 100
        let maxStart = 1000
        
        var offset = 1
        var words: [NewlyCoinedWord] = []
        
        let group = DispatchGroup()
        
        let start = CFAbsoluteTimeGetCurrent() // for test
        while offset <= maxStart {
            
            group.enter()
            APIService.searchEncyc(query: query, display: maxDisplay, start: offset) { result, error in
                
                if let error = error {
                    print("신조어 리스트 가져오기 실패!")
                    dump(error)
                    
                    group.leave()
                    return
                }
                
                
                if let result = result {
                    print("신조어 리스트 가져오기 성공!")
                
                    print(Thread.current.description)  // for test
                    let start = CFAbsoluteTimeGetCurrent()  // for test
                    let postProcessed: [NewlyCoinedWord] = result.items
                        .map {
                            
                            let description = $0.itemDescription.withoutHTMLTags
                                .components(separatedBy: ". ").first ?? ""
                            
                            let word = NewlyCoinedWord(title: $0.title.withoutHTMLTags, description: description)
                            
                            return word
                        }
                        .filter {
                            
                            !($0.title.contains("신조어")) &&
                            !($0.title.contains("신어")) &&
                            !($0.description.contains("..")) &&
                            !($0.description.contains("영상")) &&
                            $0.description.contains("신조어")
                        }
                    
                    let end = CFAbsoluteTimeGetCurrent()  // for test
                    print("elasped time: \(end - start)")  // for test
                    
                    words.append(contentsOf: postProcessed)
                    
                }
                
                group.leave()
                
            }
            
            offset += maxDisplay
        }
        
        group.notify(queue: .main) {
            
            let end = CFAbsoluteTimeGetCurrent()  // for test
            print("total elasped time: \(end - start)")  // for test
            
            UserDefaults.wordList = words
            self.wordList.value = UserDefaults.wordList
            
            completion()
        }
        
    }
    
    func makeHashTags() {
        
        let number = wordList.value.count > maxHashTagsNumber ? maxHashTagsNumber : wordList.value.count
        
        hashTags.value.removeAll()
        repeat {
            
            guard let word = wordList.value.randomElement() else {
                print("신조어 리스트가 없음!")
                return
            }
            
            let isContain = hashTags.value.contains(where: {
                return $0 == word ? true : false
            })
            
            if !isContain { hashTags.value.append(word) }
            
        } while(hashTags.value.count < number)
        
    }
}

extension NewlyCoinedWordViewModel: UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int {
        return hashTags.value.count
    }
}
