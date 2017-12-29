//
//  Constants.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 14/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation

enum SelectionType: String, Codable {
    case ship = "Ship"
    case pilot = "Pilot"
    case upgrade = "Upgrade"
}

enum Faction: String, Codable {
    case rebelAlliance = "Rebel Alliance"
    case galacticEmpire = "Galactic Empire"
    case scumAndVillainy = "Scum and Villainy"
    case resistance = "Resistance"
    case firstOrder = "First Order"
    case mixed = "Mixed"
}

enum UpgradeType: String, Codable {
    case elite = "Elite"
    case turret = "Turret"
    case torpedo = "Torpedo"
    case astromech = "Astromech"
    case missile = "Missile"
    case crew = "Crew"
    case cannon = "Cannon"
    case bomb = "Bomb"
    case system = "System"
    case cargo = "Cargo"
    case hardpoint = "Hardpoint"
    case team = "Team"
    case illicit = "Illicit"
    case salvagedAstromech = "Salvaged Astromech"
    case title = "Title"
    case tech = "Tech"
    case modification = "Modification"
}

enum ShipType: String, Codable {
    case xWing = "X-wing"
    case yWing = "Y-wing"
    case aWing = "A-wing"
    case yt1300 = "YT-1300"
    case tieFighter = "TIE Fighter"
    case tieAdvanced = "TIE Advanced"
    case tieInterceptor = "TIE Interceptor"
    case firespray31 = "Firespray-31"
    case hwk290 = "HWK-290"
    case lambdaClassShuttle = "Lambda-class Shuttle"
    case bWing = "B-wing"
    case tieBomber = "TIE Bomber"
    case gr75mediumTransport = "GR-75 Medium Transport"
    case z95headhunter = "Z-95 Headhunter"
    case tieDefender = "TIE Defender"
    case eWing = "E-wing"
    case tiePhantom = "TIE Phantom"
    case cr90corvetteFore = "CR90 Corvette (Fore)"
    case cr90corvetteAft = "CR90 Corvette (Aft)"
    case yt2400 = "YT-2400"
    case vt49decimator = "VT-49 Decimator"
    case starViper = "StarViper"
    case m3aInterceptor = "M3-A Interceptor"
    case aggressor = "Aggressor"
    case raiderClassCorvetteFore = "Raider-class Corvette (Fore)"
    case raiderClassCorvetteAft = "Raider-class Corvette (Aft)"
    case yv666 = "YV-666"
    case kihraxzFighter = "Kihraxz Fighter"
    case kWing = "K-wing"
    case tiePunisher = "TIE Punisher"
    case t70xWing = "T-70 X-wing"
    case tieFoFighter = "TIE/fo Fighter"
    case vcx100 = "VCX-100"
    case attackShuttle = "Attack Shuttle"
    case jumpmaster5000 = "JumpMaster 5000"
    case g1aStarfighter = "G-1A Starfighter"
    case tieAdvPrototype = "TIE Adv. Prototype"
    case gozantiClassCruiser = "Gozanti-class Cruiser"
    case arc170 = "ARC-170"
    case tieSfFighter = "TIE/sf Fighter"
    case protectorateStarfighter = "Protectorate Starfighter"
    case lancerClassPursuitCraft = "Lancer-class Pursuit Craft"
    case upsilonClassShuttle = "Upsilon-class Shuttle"
    case quadjumper = "Quadjumper"
    case tieStriker = "TIE Striker"
    case uWing = "U-wing"
    case cRocCruiser = "C-ROC Cruiser"
    case auzituckGunship = "Auzituck Gunship"
    case tieAggressor = "TIE Aggressor"
    case scurrgH6bomber = "Scurrg H-6 Bomber"
    case alphaClassStarWing = "Alpha-class Star Wing"
    case m12lKimogilaFighter = "M12-L Kimogila Fighter"
    case sheathipedeClassShuttle = "Sheathipede-class Shuttle"
    case tieSilencer = "TIE Silencer"
    case bSf17bomber = "B/SF-17 Bomber"
}
