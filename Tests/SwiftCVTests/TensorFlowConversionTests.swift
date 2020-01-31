import XCTest
import TensorFlow
@testable import SwiftCV

fileprivate let fixturesFolder = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("fixtures") 

final class TensorFlowConversionTests: XCTestCase {
    func testShapedArrayConversion() {
        let imgFilename = fixturesFolder.appendingPathComponent("test.png").path
        let img: Mat = imread(imgFilename)
        let arr = ShapedArray<Int8>(cvMat: img)!
        XCTAssertEqual(arr.shape, [1200, 1200, 3])
    }

    func testTensorConversion() {
        let imgFilename = fixturesFolder.appendingPathComponent("test.png").path
        let img: Mat = imread(imgFilename)
        let tens = Tensor<Int8>(cvMat: img)!
        XCTAssertEqual(tens.shape, [1200, 1200, 3])
    }

    func testMatConversion() {
        let tensor = Tensor<Int8>(Tensor<Float>(randomNormal: [4, 4, 3]) * 255)
        let mat = Mat(fromTensor: tensor)
        let backToTensor = Tensor<UInt8>(cvMat: mat)
        XCTAssertEqual(mat, backToTensor)
    }

    static var allTests = [
        ("testShapedArrayConversion", testShapedArrayConversion),
        ("testTensorConversion", testTensorConversion),
        ("testMatConversion", testMatConversion)
    ]
}
