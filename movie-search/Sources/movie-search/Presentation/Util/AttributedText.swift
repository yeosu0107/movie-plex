//
//  AttributedText.swift
//  
//
//  ref.
//  https://github.com/Iaenhaall/AttributedText
//

import SwiftUI

public struct AttributedText: View {
    /// Set of supported tags and associated modifiers. This is used by default for all AttributedText
    /// instances except those for which this parameter is defined in the initializer.
    public static var tags: Dictionary<String, (Text) -> (Text)> = [
        "h1": { $0.font(.largeTitle) },
        "h2": { $0.font(.title) },
        "h3": { $0.font(.headline) },
        "h4": { $0.font(.subheadline) },
        "h5": { $0.font(.callout) },
        "h6": { $0.font(.caption) },
        
        "i": { $0.italic() },
        "u": { $0.underline() },
        "s": { $0.strikethrough() },
        "b": { $0.fontWeight(.bold) },
        
        "sup": { $0.baselineOffset(10).font(.footnote) },
        "sub": { $0.baselineOffset(-10).font(.footnote) }
    ]
    /// Parser formatted text.
    private let text: Text

    /**
     Creates a text view that displays formatted content.
     
     - parameter htmlString: HTML-tagged string.
     - parameter tags: Set of supported tags and associated modifiers for a particular instance.
     */
    public init(_ htmlString: String, tags: Dictionary<String, (Text) -> (Text)>? = nil) {
        let parser = HTML2TextParser(htmlString, availableTags: tags == nil ? AttributedText.tags : tags!)
        parser.parse()
        text = parser.formattedText
    }

    public var body: some View {
        text
    }
}

internal class HTML2TextParser {
    /// The result of the parser's work.
    internal private(set) var formattedText = Text("")
    /// HTML-tagged text.
    private let htmlString: String
    /// Set of currently active tags.
    private var tags: Set<String> = []
    /// Set of supported tags and associated modifiers.
    private let availableTags: Dictionary<String, (Text) -> (Text)>

    /**
     Creates a new parser instance.
     
     - parameter htmlString: HTML-tagged string.
     - parameter availableTags: Set of supported tags and associated modifiers.
     */
    internal init(_ htmlString: String, availableTags: Dictionary<String, (Text) -> (Text)>) {
        self.htmlString = htmlString
        self.availableTags = availableTags
    }

    /// Starts the text parsing process. The results of this method will be placed in the `formattedText` variable.
    internal func parse() {
        var tag: String? = nil
        var endTag: Bool = false
        var startIndex = htmlString.startIndex
        var endIndex = htmlString.startIndex

        for index in htmlString.indices {
            switch htmlString[index] {
            case "<":
                tag = String()
                endIndex = index
                continue

            case "/":
                if index != htmlString.startIndex && htmlString[htmlString.index(before: index)] == "<" {
                    endTag = true
                } else {
                    tag = nil
                }
                continue

            case ">":
                if let tag = tag {
                    addChunkOfText(String(htmlString[startIndex..<endIndex]))
                    if endTag {
                        tags.remove(tag.lowercased())
                        endTag = false
                    } else {
                        tags.insert(tag.lowercased())
                    }
                    startIndex = htmlString.index(after: index)
                }
                tag = nil
                continue

            default:
                break
            }

            if tag != nil {
                if htmlString[index].isLetter || htmlString[index].isHexDigit {
                    tag?.append(htmlString[index])
                } else {
                    tag = nil
                }
            }
        }

        endIndex = htmlString.endIndex
        if startIndex != endIndex {
            addChunkOfText(String(htmlString[startIndex..<endIndex]))
        }
    }

    private func addChunkOfText(_ string: String) {
        guard !string.isEmpty else { return }
        var textChunk = Text(string)

        for tag in tags {
            if let action = availableTags[tag] {
                textChunk = action(textChunk)
            }
        }

        formattedText = formattedText + textChunk
    }
}
