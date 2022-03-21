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
    
    
    var searchWord: Observable<NewlyCoinedWord> = Observable(NewlyCoinedWord(title: "", description: ""))
    
    
    func searchQuery(query: String, display: Int, start: Int) {
        
        APIService.searchEncyc(query: query, display: display, start: start) { result, error in
            
            if let error = error {
                print("신조어 검색 실패!")
                dump(error)
                return
            }
            
            if let result = result {
                print("신조어 검색 성공!")
                
                /* sort=sim이므로,
                 가장 유사도가 높을 first로 선택
                 */
                if let item = result.items.first  {
                    
                    let title = item.title.withoutHTMLTags
                    let description = item.itemDescription.withoutHTMLTags.components(separatedBy: ". ").first ?? ""
                    
                    let word = NewlyCoinedWord(title: title, description: description)
                    
                    self.searchWord.value = word
                    print(self.searchWord.value)
                }
            }
        }
    }
    
    func searchWords(query: String) {
        
        let maxDisplay = 100
        let maxStart = 1000
        
        var pagination = 1
        var words: [NewlyCoinedWord] = []
        while pagination <= maxStart {
            
            APIService.searchEncyc(query: query, display: maxDisplay, start: pagination) { result, error in
                
                if let error = error {
                    print("신조어 리스트 가져오기 실패!")
                    dump(error)
                    return
                }
                
                if let result = result {
                    print("신조어 리스트 가져오기 성공!")
                    
                    result.items.forEach { item in
                        
                        let word = NewlyCoinedWord(title: item.title.withoutHTMLTags, description: item.itemDescription.withoutHTMLTags)
                        
                        words.append(word)
                        
                    }
                }
            }
            pagination += maxDisplay
        }
        
        wordList.value = words
        
        /* 해시태그 생성 필요 */
        
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
