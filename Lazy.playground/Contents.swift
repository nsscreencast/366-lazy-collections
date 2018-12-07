import Foundation


var globalPartList: [String] = []
func getPartNumber() -> String {
    let partNumber = String(Int.random(in: 1000..<9999))
    globalPartList.append(partNumber)
    return partNumber
}

struct Part : CustomStringConvertible {
    let partNumber: String
    
    var description: String {
        return "Part: \(partNumber)"
    }
    
    static func make() -> Part {
        return Part(partNumber: getPartNumber())
    }
}

struct Component {
    let parts: [Part]

    static func make() -> Component {
        return Component(parts: (0..<5).map { _ in Part.make() })
    }
}

struct Subsystem {
    let components: [Component]

    static func make() -> Subsystem {
        return Subsystem(components: (0..<5).map { _ in Component.make() })
    }
}

struct System {
    let subsystems: [Subsystem]
    
    static func make() -> System {
        return System(subsystems: (0..<5).map { _ in Subsystem.make() })
    }
}

let system = System.make()
dump(system)

func findPart(_ num: String, in system: System) -> Part? {
    
    return system.subsystems.lazy
        .flatMap { $0.components }
        .flatMap { $0.parts }
        .first(where: { $0.partNumber ==  num })

}

/*
 [] -> {} -> *
 [] -> {} -> *
 [] -> {} -> *
 
 [] -> {} -> *
 [] -> {} -> *
 */

findPart(globalPartList.randomElement()!, in: system)
