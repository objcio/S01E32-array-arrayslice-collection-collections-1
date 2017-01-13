import Cocoa

extension Array {
    func split(batchSize: Int) -> [[Element]] {
        return self[startIndex..<endIndex].split(batchSize: batchSize)
    }
}

extension ArraySlice {
    func split(batchSize: Int) -> [[Element]] {
        var result: [[Element]] = []
        for start in stride(from: startIndex, to: endIndex, by: batchSize) {
            let end = Swift.min(start + batchSize, endIndex)
            result.append(Array(self[start..<end]))
        }
        return result
    }
}

// The extensions on `Collection` only get used once the more specific variants on `Array` and `ArraySlice` are removed
extension Collection where Index == Int {
    func split(batchSize: Int) -> [SubSequence] {
        var result: [SubSequence] = []
        for start in stride(from: startIndex, to: endIndex, by: batchSize) {
            let end = Swift.min(start + batchSize, endIndex)
            result.append(self[start..<end])
        }
        return result
    }
}


extension Collection {
    func split(batchSize: IndexDistance) -> [SubSequence] {
        var remainderIndex = startIndex
        var result: [SubSequence] = []
        while remainderIndex < endIndex {
            let batchEndIndex = index(remainderIndex, offsetBy: batchSize, limitedBy: endIndex) ?? endIndex
            result.append(self[remainderIndex..<batchEndIndex])
            remainderIndex = batchEndIndex
        }
        return result
    }
}


let array: [Int] = [1, 2, 3]
let slice = array.suffix(from: 1)

array.split(batchSize: 1)
array.split(batchSize: 2)
array.split(batchSize: 3)
array.split(batchSize: 4)

slice.split(batchSize: 1)
slice.split(batchSize: 2)
slice.split(batchSize: 3)

