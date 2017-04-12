import Swinject
import Cobra


/**
The ServiceAssembly assembles the services of the application
*/
final class ServiceAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension ServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CityServiceType.self) { _ in
            return CityService()
        }
        container.register(WeatherServiceType.self) { _ in
            return WeatherService()
        }
    }

    func loaded(resolver: Resolver) {

    }
}
