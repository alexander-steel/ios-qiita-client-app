//
//  QiitaItemARView.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/18.
//

import Foundation
import UIKit
import SceneKit
import ARKit


class QiitaItemARViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!

    var qiitaItemImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        setImageToScene(image: qiitaItemImage ?? getImageByUrl(url: "https://ichef.bbci.co.uk/news/640/cpsprodpb/17A21/production/_85310869_85310700.jpg"))
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    }


    func setupScene(){
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.debugOptions = [.showFeaturePoints]
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }


    private func setImageToScene(image: UIImage) {
        if let camera = sceneView.pointOfView {
            let position = SCNVector3(x: 0, y: 0, z: -1.0)
            let convertPosition = camera.convertPosition(position, to: nil)
            let node = createQiitaNode(image, position: convertPosition)
            self.sceneView.scene.rootNode.addChildNode(node)
        }
    }

    private func createQiitaNode(_ image: UIImage, position: SCNVector3) -> SCNNode {
        let node = SCNNode()
        let scale: CGFloat = 0.3
        let geometry = SCNBox(width: image.size.width * scale / image.size.height,
                              height: scale,
                              length: 0.00000001,
                              chamferRadius: 0.0)
        geometry.firstMaterial?.diffuse.contents = image
        node.geometry = geometry
        node.position = position
        return node
    }
}
