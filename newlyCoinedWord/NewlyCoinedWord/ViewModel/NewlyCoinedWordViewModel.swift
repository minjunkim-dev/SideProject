//
//  NewlyCoinedWordViewModel.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

final class NewlyCoinedWordViewModel {
    
    var wordList: Observable<[NewlyCoinedWord]> = Observable([])
    var hashTags: Observable<[NewlyCoinedWord]> = Observable([])
    let maxHashTagsNumber = 5
    
    var searchWord: Observable<NewlyCoinedWord> = Observable(NewlyCoinedWord(title: "", description: ""))
    
    
    func searchQuery(query: String, completion: @escaping () -> Void) {
        
        let group = DispatchGroup()
        group.enter()
        
        let results = wordList.value.filter {
            $0.title.contains(query)
        }
        
        if let result = results.first {
            print("신조어 검색 성공!")
            self.searchWord.value = result
        } else {
            print("신조어 검색 실패!")
        }
        
        completion()
    }
    
    func searchWords(query: String, completion: @escaping () -> Void) {
        
        let maxDisplay = 100
        let maxStart = 1000
        
        var offset = 1
        var words: [NewlyCoinedWord] = []
        
        let group = DispatchGroup()
        while offset <= maxStart {
            
            let tempOffset = offset
            print("offset: \(tempOffset) / API 호출 시작")
            
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
                    
                    words = result.items
                        .map { item in
                        
                        let word = NewlyCoinedWord(title: item.title.withoutHTMLTags, description: item.itemDescription.withoutHTMLTags)
                        
                            return word
                        }
                        .filter { $0.description.contains("신조어") }
                    
                    print("offset: \(tempOffset) / 후처리 완료")
                }
                
                group.leave()
            }
            
            offset += maxDisplay
        }
        
        
        group.notify(queue: .main) {
            
            print("notify")
            
            self.wordList.value = words
            
            /* 해시태그 생성 필요 */
            self.wordList.value.count > self.maxHashTagsNumber ?
            self.makeHashTags(number: self.maxHashTagsNumber) :
            self.makeHashTags(number: self.wordList.value.count)
            
            completion()
        }
        
    }
    
    private func makeHashTags(number: Int) {
        
        repeat {
            
            let word = wordList.value.randomElement()!
            
            let isContain = hashTags.value.contains(where: {
                if $0.title == word.title, $0.description == word.description {
                    return true
                } else {
                    return false
                }
            })
            
            if !isContain { hashTags.value.append(word) }
            
        } while(hashTags.value.count < number)
        
    }
}

extension NewlyCoinedWordViewModel: UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int {
        return hashTags.value.count
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HashTagCollectionViewCell.reuseIdentifier, for: indexPath) as? HashTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        let word = hashTags.value[row]
        cell.configureCell(newlyCoinedWord: word.title)
        
        return cell
    }
}
