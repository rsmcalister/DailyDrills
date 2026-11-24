import Foundation

enum CurriculumLoader {
    enum LoadError: LocalizedError {
        case fileMissing

        var errorDescription: String? {
            "curriculum.json was not found in the app bundle."
        }
    }

    static func loadBundled() throws -> Curriculum {
        guard let url = Bundle.main.url(forResource: "curriculum", withExtension: "json") else {
            throw LoadError.fileMissing
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Curriculum.self, from: data)
    }
}
