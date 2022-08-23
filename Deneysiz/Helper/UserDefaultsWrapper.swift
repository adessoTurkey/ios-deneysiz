import Foundation

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    struct Wrapper<T>: Codable where T: Codable {
        let wrapped: T
    }

    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data
                else { return defaultValue }
            let value = try? JSONDecoder().decode(Wrapper<T>.self, from: data)
            return value?.wrapped ?? defaultValue
        }
        set {
            do {
                let data = try JSONEncoder().encode(Wrapper(wrapped: newValue))
                UserDefaults.standard.set(data, forKey: key)
            } catch {
//                let errorDict: [String: Any] = ["detail": "Error while encoding key: \(key) value: \(newValue)"]
//                Logger.shared.log(errorDict)
            }
        }
    }
}
