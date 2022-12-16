//
//  FilterUtil.swift
//  Instafilter
//
//  Created by Tianhao Liu on 12/15/22.
//

import Foundation
import SwiftUI
import Combine
import CoreImage
import CoreImage.CIFilterBuiltins

class FilterModel: ObservableObject {
    enum FilterType: String, CaseIterable, Identifiable {
        case sepiaTone = "Sepia Tone"
        case vignette = "Vignetter"
        case gloom = "Gloom"
        
        var id: Self { self }
    }
    
    @Published var intensity = 0.5
    @Published var inputImage: UIImage? = nil
    @Published var processedImage: UIImage? = nil
    @Published var filterType: FilterType = .sepiaTone {
        didSet {
            switch filterType {
            case .sepiaTone:
                currentFilter = CIFilter.sepiaTone()
            case .vignette:
                currentFilter = CIFilter.vignette()
            case .gloom:
                currentFilter = CIFilter.gloom()
            }
        }
    }
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    private var cancellables = Set<AnyCancellable>()
    private let context = CIContext()
    
    init() {
        Publishers.CombineLatest3($currentFilter, $intensity, $inputImage.compactMap({ $0 }))
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .sink { _ in } receiveValue: { [weak self] filter, intensity, image in
                guard let self = self else { return }
                self.applyProcessing(filter: filter, intensity: intensity, image: image)
            }
            .store(in: &cancellables)
    }
    
    private func applyProcessing(filter: CIFilter, intensity: Double, image inputImage: UIImage) {
        let inputKeys = currentFilter.inputKeys
        currentFilter.setValue(CIImage(image: inputImage), forKey: kCIInputImageKey)
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity * 200, forKey: kCIInputRadiusKey) }
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            processedImage = UIImage(cgImage: cgimg)
        }
    }
}
