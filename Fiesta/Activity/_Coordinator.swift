//
//  _Coordinator.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/18.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?

    init(isShown: Binding<Bool>, image: Binding<Image?>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
    }

    func imagePickerController(_: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageInCoordinator = Image(uiImage: unwrapImage)
        isCoordinatorShown = false
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
