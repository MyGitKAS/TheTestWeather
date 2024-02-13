import UIKit

class WeatherScaleView: UIView {
    
    private var maxWeek: Float = 0
    private var minWeek: Float = 0
    private var maxday: Float = 0
    private var minDay: Float = 0
    private var curentTemp: Float = 0
    
    // Set colors
    private let backColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    private let progressColor: UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    private let dotColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    private let generalFrame = CGRect(x: 0, y: 0, width: 80, height: 5)
    private var isDrawDot = false
    private var thickness: CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: generalFrame)
       setGeneral()
    }
    
    init(minWeek: Float, maxWeek: Float, minDay: Float, maxDay: Float, current: Float) {
      super.init(frame: generalFrame)
        self.isDrawDot = true
        setGeneral()
     }
    
    init(minWeek: Float, maxWeek: Float, minDay: Float, maxDay: Float) {
      super.init(frame: generalFrame)
        setGeneral()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGeneral() {
        thickness = frame.height
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawBackgroundLine()
        drawProgressLine()
        if isDrawDot{
            drawDot()
        }
    }

   private func drawBackgroundLine() {
        let backgroundLine = UIBezierPath(roundedRect: CGRect(x: 0, y: bounds.height/2 - thickness / 2, width: bounds.width, height: thickness), cornerRadius: thickness / 2)
        backColor.setFill()
        backgroundLine.fill()
    }
    
    private func drawDot() {
        let startPoint = (Float(bounds.width) / 100) * returnStartPoint(startPoint: minWeek, endPoint: maxWeek, targetPoint: curentTemp) - Float(thickness / 2)
        
        if let context = UIGraphicsGetCurrentContext() {
            let borderRect = CGRect(x: CGFloat(startPoint), y: bounds.height / 2 - thickness / 2, width: thickness, height: thickness)
            let currentDot = UIBezierPath(ovalIn: borderRect)
            
            // Add border
            context.setLineWidth(thickness / 1.5)
            context.setStrokeColor(backColor.cgColor)
            context.addPath(currentDot.cgPath)
            context.strokePath()
            
            dotColor.setFill()
            currentDot.fill()
    
            context.restoreGState()
        }
    }
    
    private func drawProgressLine() {
            let startPoint = (Float(bounds.width) / 100) * returnStartPoint(startPoint: minWeek, endPoint: maxWeek, targetPoint:minDay )
        let endPoint = (Float(bounds.width) / 100) * calculateLenght(minWeek: minWeek, maxWeek: maxWeek, minDay: minDay, maxday: maxday)
            
            let fillLine = UIBezierPath(roundedRect: CGRect(x: CGFloat(startPoint), y: bounds.height / 2 - thickness / 2, width: CGFloat(endPoint), height: thickness), cornerRadius: thickness / 2)
               progressColor.setFill()
               fillLine.fill()
           }
    }


// Calculates
extension WeatherScaleView {

    private  func calculateLenght(minWeek: Float, maxWeek: Float, minDay: Float, maxday: Float) -> Float {
        let onePercent = (maxWeek - minWeek) / 100
        let progress = (maxday - minDay) / onePercent
        return progress
    }

    private  func returnStartPoint(startPoint: Float, endPoint: Float, targetPoint: Float) -> Float {
    let totalDistance = abs(startPoint - endPoint)
            let distanceFromA = abs(targetPoint - startPoint)
            let distancePercentage = distanceFromA / totalDistance * 100.0
            return distancePercentage
    }
}
// Set values
extension WeatherScaleView {
    func setParametrs(minWeek: Float, maxWeek: Float, minDay: Float, maxDay: Float, current: Float) {
        self.minWeek = minWeek
        self.maxWeek = maxWeek
        self.minDay = minDay
        self.maxday = maxDay
        self.curentTemp = current
        isDrawDot = true
    }
    
    func setParametrs(minWeek: Float, maxWeek: Float, minDay: Float, maxDay: Float) {
        self.minWeek = minWeek
        self.maxWeek = maxWeek
        self.minDay = minDay
        self.maxday = maxDay
    }
}
