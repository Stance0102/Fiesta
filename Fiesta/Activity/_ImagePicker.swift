//
//  _ImagePicker.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/18.
//

import SwiftUI
import UIKit

struct ImagePicker {
    @Binding var isShown: Bool
    @Binding var image: Image?

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
}

extension ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController
    {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary

        return picker
    }

    func updateUIViewController(_: UIImagePickerController, context _: UIViewControllerRepresentableContext<ImagePicker>) {}
}
