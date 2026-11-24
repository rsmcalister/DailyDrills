import Foundation

enum CurriculumLoader {
    static let resourceName = "curriculum"
    static let resourceExtension = "json"

    enum LoadError: LocalizedError {
        case fileMissing(String)

        var errorDescription: String? {
            switch self {
            case .fileMissing(let name): "\(name) was not found in the app bundle."
            }
        }
    }

    static func loadBundled() throws -> Curriculum {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: resourceExtension) else {
            throw LoadError.fileMissing("\(resourceName).\(resourceExtension)")
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            try DrillDate.parse(decoder.singleValueContainer().decode(String.self))
        }
        return try decoder.decode(Curriculum.self, from: data)
    }
}
