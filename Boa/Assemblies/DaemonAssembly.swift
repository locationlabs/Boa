import Swinject
import Cobra
import Medusa


/**
The DaemonAssembly assembles the daemons of the application
*/
final class DaemonAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension DaemonAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(AppStateDaemon.self) { _ in
            return AppStateDaemon()
        }
    }

    func loaded(resolver: ResolverType) {
        DaemonManager.sharedInstance.register(resolver.resolve(AppStateDaemon.self)!)
    }
}
