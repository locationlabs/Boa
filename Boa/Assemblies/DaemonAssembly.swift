import Swinject
import Cobra
import Gorgon


/**
The DaemonAssembly assembles the daemons of the application
*/
final class DaemonAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension DaemonAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppStateDaemon.self) { _ in
            return AppStateDaemon()
        }
    }

    func loaded(_ resolver: Resolver) {
        DaemonManager.sharedInstance.register(resolver.resolve(AppStateDaemon.self)!)
    }
}
