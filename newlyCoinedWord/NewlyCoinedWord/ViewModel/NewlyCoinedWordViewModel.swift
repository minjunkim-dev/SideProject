//
//  NewlyCoinedWordViewModel.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

final class NewlyCoinedWordViewModel {
    
    var wordList: Observable<[NewlyCoinedWord]> = Observable([])
    
    var maxHashTagsNumber: Int = 5
    var hashTags: Observable<[NewlyCoinedWord]> = Observable([])
    
    var searchWord: Observable<NewlyCoinedWord> = Observable(NewlyCoinedWord(title: "", description: ""))
    
    func searchQuery(query: String, completion: @escaping (SearchResult) -> Void) {
        
        let group = DispatchGroup()
        group.enter()
        
        let results = wordList.value.filter {
            $0.title.compare(query, options: .caseInsensitive) == .orderedSame
        }
        
        if let result = results.first {
            print("신조어 검색 성공!")
            self.searchWord.value = result
            completion(.success)
        } else {
            print("신조어 검색 실패!")
            completion(.failure)
        }
    }
    
    func searchWords(query: String, completion: @escaping () -> Void) {
        
        let maxDisplay = 100
        let maxStart = 1000
        
        var offset = 1
        var words: [NewlyCoinedWord] = []
        
        let group = DispatchGroup()
        
        let start = CFAbsoluteTimeGetCurrent()
        
        while offset <= maxStart {
            
            group.enter()
            APIService.searchEncyc(query: query, display: maxDisplay, start: offset) { result, error in
                
                if let error = error {
                    print("신조어 리스트 가져오기 실패!")
                    dump(error)
                    
                    group.leave()
                    return
                }
                
                print(Thread.current.description)
                if let result = result {
                    print("신조어 리스트 가져오기 성공!")
                    
                    let start = CFAbsoluteTimeGetCurrent()
                    print("start 완료?", result.items.count)
                    
                    
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
                    print("preProcessed 완료?")
                    
                    let end = CFAbsoluteTimeGetCurrent()
                    print("elasped time: \(end - start)")
                    
                    print("후처리 완료!")
                    words.append(contentsOf: postProcessed)
                    
                }
                
                group.leave()
                
            }
            
            offset += maxDisplay
        }
        
        print("notify 호출")
        group.notify(queue: .main) {
            
            let end = CFAbsoluteTimeGetCurrent()
            print("total elasped time: \(end - start)")
            
            UserDefaults.wordList = words
            self.wordList.value = UserDefaults.wordList
            
            self.wordList.value.count > self.maxHashTagsNumber ?
            self.makeHashTags(number: self.maxHashTagsNumber) :
            self.makeHashTags(number: self.wordList.value.count)
            
            completion()
        }
        
    }
    
    func makeHashTags(number: Int) {
        
        repeat {
            
            guard let word = wordList.value.randomElement() else {
                print("신조어 리스트가 없음!")
                return
            }
            
            let isContain = hashTags.value.contains(where: {
                print($0 == word)
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
