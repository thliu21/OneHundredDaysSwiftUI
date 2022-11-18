//
//  Astronaut.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/10/22.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    enum AstronautId: String, Codable {
        case aldrin = "aldrin"
        case anders = "anders"
        case armstrong = "armstrong"
        case bean = "bean"
        case borman = "borman"
        case cernan = "cernan"
        case chaffee = "chaffee"
        case collins = "collins"
        case conrad = "conrad"
        case cunningham = "cunningham"
        case duke = "duke"
        case eisele = "eisele"
        case evans = "evans"
        case gordon = "gordon"
        case grissom = "grissom"
        case haise = "haise"
        case irwin = "irwin"
        case lovell = "lovell"
        case mattingly = "mattingly"
        case mcdivitt = "mcdivitt"
        case mitchell = "mitchell"
        case roosa = "roosa"
        case schirra = "schirra"
        case schmitt = "schmitt"
        case schweickart = "schweickart"
        case scott = "scott"
        case shepard = "shepard"
        case stafford = "stafford"
        case swigert = "swigert"
        case white = "white"
        case worden = "worden"
        case young = "young"
    }
    
    let id: AstronautId
    let name: String
    let description: String
    
    var image: ImageAsset {
        switch self.id {
        case .aldrin:
            return ImageAssets.aldrin
        case .anders:
            return ImageAssets.anders
        case .armstrong:
            return ImageAssets.armstrong
        case .bean:
            return ImageAssets.bean
        case .borman:
            return ImageAssets.borman
        case .cernan:
            return ImageAssets.cernan
        case .chaffee:
            return ImageAssets.chaffee
        case .collins:
            return ImageAssets.collins
        case .conrad:
            return ImageAssets.conrad
        case .cunningham:
            return ImageAssets.cunningham
        case .duke:
            return ImageAssets.duke
        case .eisele:
            return ImageAssets.eisele
        case .evans:
            return ImageAssets.evans
        case .gordon:
            return ImageAssets.gordon
        case .grissom:
            return ImageAssets.grissom
        case .haise:
            return ImageAssets.haise
        case .irwin:
            return ImageAssets.irwin
        case .lovell:
            return ImageAssets.lovell
        case .mattingly:
            return ImageAssets.mattingly
        case .mcdivitt:
            return ImageAssets.mcdivitt
        case .mitchell:
            return ImageAssets.mitchell
        case .roosa:
            return ImageAssets.roosa
        case .schirra:
            return ImageAssets.schirra
        case .schmitt:
            return ImageAssets.schmitt
        case .schweickart:
            return ImageAssets.schweickart
        case .scott:
            return ImageAssets.scott
        case .shepard:
            return ImageAssets.shepard
        case .stafford:
            return ImageAssets.stafford
        case .swigert:
            return ImageAssets.swigert
        case .white:
            return ImageAssets.white
        case .worden:
            return ImageAssets.worden
        case .young:
            return ImageAssets.young
        }
    }
}
