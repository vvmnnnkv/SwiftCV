import COpenCV

public func ImShow(image: Mat, windowName: String = "OpenCV") -> () {
    Window_IMShow(
        windowName,
        image.p
    )
}

@discardableResult
public func WaitKey(delay: Int32) -> Int32 {
	return Window_WaitKey(delay)
}
