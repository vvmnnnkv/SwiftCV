import COpenCV

public class VideoCapture {
    let cap: COpenCV.VideoCapture

    public init(_ device: Int32) {
        self.cap = VideoCapture_New()
        VideoCapture_OpenDevice(self.cap, device)
    }

    public func read(into frame: Mat) {
        VideoCapture_Read(self.cap, frame.p)
    }

    public func set(_ prop: VideoCaptureProperties, _ param: Double) {
        VideoCapture_Set(self.cap, prop.rawValue, param) 
    }
}
