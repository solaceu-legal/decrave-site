import AppKit

struct PosterSpec {
    let outputName: String
    let screenshotName: String
    let headline: String
    let accentLine: String
    let subtitle: String
    let accent: NSColor
}

let canvas = NSSize(width: 1284, height: 2778)
let root = URL(fileURLWithPath: CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : FileManager.default.currentDirectoryPath)
let backgroundURL = root.appendingPathComponent("assets/poster-background-v1.png")
let outputDirectory = root.appendingPathComponent("posters")

let specs = [
    PosterSpec(outputName: "01-start-anyway.png", screenshotName: "01-home.png", headline: "Still smoking?", accentLine: "Start anyway.", subtitle: "No quit date required.", accent: NSColor(calibratedRed: 0.20, green: 0.91, blue: 0.82, alpha: 1)),
    PosterSpec(outputName: "02-next-move.png", screenshotName: "02-sos.png", headline: "One tap to", accentLine: "your next move.", subtitle: "Support shaped by your own patterns.", accent: NSColor(calibratedRed: 0.38, green: 0.79, blue: 1.00, alpha: 1)),
    PosterSpec(outputName: "03-never-resets.png", screenshotName: "06-never-reset.png", headline: "Progress that", accentLine: "never resets.", subtitle: "Every win still counts after a slip.", accent: NSColor(calibratedRed: 0.24, green: 0.94, blue: 0.68, alpha: 1)),
    PosterSpec(outputName: "04-patterns.png", screenshotName: "04-progress.png", headline: "See what drives", accentLine: "your cravings.", subtitle: "Spot triggers, peak times, and trends.", accent: NSColor(calibratedRed: 0.34, green: 0.72, blue: 1.00, alpha: 1)),
    PosterSpec(outputName: "05-hard-moments.png", screenshotName: "03-toolbox.png", headline: "More tools for", accentLine: "hard moments.", subtitle: "Choose a quick step that fits the moment.", accent: NSColor(calibratedRed: 1.00, green: 0.48, blue: 0.34, alpha: 1)),
    PosterSpec(outputName: "06-breathe.png", screenshotName: "05-breathing.png", headline: "Breathe through", accentLine: "the next minute.", subtitle: "Short guided breathing, right when you need it.", accent: NSColor(calibratedRed: 0.55, green: 0.54, blue: 1.00, alpha: 1)),
]

func image(at url: URL) -> NSImage {
    guard let result = NSImage(contentsOf: url) else {
        fatalError("Could not load \(url.path)")
    }
    return result
}

func bitmap(size: NSSize, draw: () -> Void) -> NSBitmapImageRep {
    let rep = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(size.width),
        pixelsHigh: Int(size.height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    )!
    rep.size = size
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
    draw()
    NSGraphicsContext.restoreGraphicsState()
    return rep
}

func drawAspectFill(_ source: NSImage, in destination: NSRect) {
    let scale = max(destination.width / source.size.width, destination.height / source.size.height)
    let size = NSSize(width: source.size.width * scale, height: source.size.height * scale)
    let rect = NSRect(
        x: destination.midX - size.width / 2,
        y: destination.midY - size.height / 2,
        width: size.width,
        height: size.height
    )
    source.draw(in: rect, from: .zero, operation: .sourceOver, fraction: 1)
}

func drawText(_ text: String, at point: NSPoint, font: NSFont, color: NSColor, kern: CGFloat = 0) {
    let style = NSMutableParagraphStyle()
    style.lineBreakMode = .byClipping
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color,
        .kern: kern,
        .paragraphStyle: style,
    ]
    NSAttributedString(string: text, attributes: attributes).draw(at: point)
}

func writePNG(_ rep: NSBitmapImageRep, to url: URL) {
    guard let data = rep.representation(using: .png, properties: [:]) else {
        fatalError("Could not encode \(url.lastPathComponent)")
    }
    try! data.write(to: url)
}

func writeJPEG(_ rep: NSBitmapImageRep, to url: URL) {
    guard let data = rep.representation(using: .jpeg, properties: [.compressionFactor: 1.0]) else {
        fatalError("Could not encode \(url.lastPathComponent)")
    }
    try! data.write(to: url)
}

try! FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)
let background = image(at: backgroundURL)
var rendered: [(PosterSpec, NSImage)] = []

for spec in specs {
    let screenshotURL = root.appendingPathComponent("raw").appendingPathComponent(spec.screenshotName)
    let screenshot = image(at: screenshotURL)
    let rep = bitmap(size: canvas) {
        drawAspectFill(background, in: NSRect(origin: .zero, size: canvas))

        let shade = NSGradient(colorsAndLocations:
            (NSColor(calibratedWhite: 0.0, alpha: 0.20), 0.0),
            (NSColor(calibratedWhite: 0.0, alpha: 0.02), 0.48),
            (NSColor(calibratedWhite: 0.0, alpha: 0.62), 1.0)
        )!
        shade.draw(in: NSRect(origin: .zero, size: canvas), angle: 90)

        drawText("DECRAVE  1.1", at: NSPoint(x: 92, y: 2668), font: .systemFont(ofSize: 27, weight: .semibold), color: NSColor.white.withAlphaComponent(0.64), kern: 3.2)
        drawText(spec.headline, at: NSPoint(x: 88, y: 2521), font: .systemFont(ofSize: 92, weight: .bold), color: .white, kern: -2.4)
        drawText(spec.accentLine, at: NSPoint(x: 88, y: 2415), font: .systemFont(ofSize: 92, weight: .bold), color: spec.accent, kern: -2.4)
        drawText(spec.subtitle, at: NSPoint(x: 92, y: 2322), font: .systemFont(ofSize: 36, weight: .medium), color: NSColor.white.withAlphaComponent(0.72), kern: -0.4)

        let phoneRect = NSRect(x: 122, y: -105, width: 1040, height: 2261)
        NSGraphicsContext.saveGraphicsState()
        let shadow = NSShadow()
        shadow.shadowColor = NSColor.black.withAlphaComponent(0.72)
        shadow.shadowBlurRadius = 44
        shadow.shadowOffset = NSSize(width: 0, height: 22)
        shadow.set()
        NSColor(calibratedWhite: 0.02, alpha: 1).setFill()
        NSBezierPath(roundedRect: phoneRect.insetBy(dx: -8, dy: -8), xRadius: 86, yRadius: 86).fill()
        NSGraphicsContext.restoreGraphicsState()

        NSGraphicsContext.saveGraphicsState()
        NSBezierPath(roundedRect: phoneRect, xRadius: 79, yRadius: 79).addClip()
        screenshot.draw(in: phoneRect, from: .zero, operation: .sourceOver, fraction: 1)
        NSGraphicsContext.restoreGraphicsState()

        spec.accent.withAlphaComponent(0.38).setStroke()
        let border = NSBezierPath(roundedRect: phoneRect.insetBy(dx: -1, dy: -1), xRadius: 80, yRadius: 80)
        border.lineWidth = 3
        border.stroke()
    }

    let outputURL = outputDirectory.appendingPathComponent(spec.outputName)
    writePNG(rep, to: outputURL)
    writeJPEG(rep, to: outputURL.deletingPathExtension().appendingPathExtension("jpg"))
    let outputImage = NSImage(size: canvas)
    outputImage.addRepresentation(rep)
    rendered.append((spec, outputImage))
}

let sheetSize = NSSize(width: 1092, height: 1658)
let sheet = bitmap(size: sheetSize) {
    NSColor(calibratedRed: 0.025, green: 0.035, blue: 0.07, alpha: 1).setFill()
    NSBezierPath(rect: NSRect(origin: .zero, size: sheetSize)).fill()
    drawText("Decrave 1.1 · App Store poster set", at: NSPoint(x: 54, y: 1591), font: .systemFont(ofSize: 34, weight: .bold), color: .white)
    drawText("Preview · 1284 × 2778 originals", at: NSPoint(x: 55, y: 1546), font: .systemFont(ofSize: 21, weight: .medium), color: NSColor.white.withAlphaComponent(0.55))

    let cardWidth: CGFloat = 306
    let cardHeight: CGFloat = 662
    let startsX: [CGFloat] = [54, 393, 732]
    let startsY: [CGFloat] = [828, 104]

    for (index, item) in rendered.enumerated() {
        let column = index % 3
        let row = index / 3
        let cardRect = NSRect(x: startsX[column], y: startsY[row], width: cardWidth, height: cardHeight)
        NSGraphicsContext.saveGraphicsState()
        let shadow = NSShadow()
        shadow.shadowColor = NSColor.black.withAlphaComponent(0.55)
        shadow.shadowBlurRadius = 18
        shadow.shadowOffset = NSSize(width: 0, height: 7)
        shadow.set()
        NSBezierPath(roundedRect: cardRect, xRadius: 26, yRadius: 26).addClip()
        item.1.draw(in: cardRect, from: .zero, operation: .sourceOver, fraction: 1)
        NSGraphicsContext.restoreGraphicsState()
        drawText(String(format: "%02d", index + 1), at: NSPoint(x: cardRect.minX + 2, y: cardRect.maxY + 11), font: .monospacedDigitSystemFont(ofSize: 20, weight: .bold), color: item.0.accent)
    }
}

writePNG(sheet, to: outputDirectory.appendingPathComponent("contact-sheet.png"))
writeJPEG(sheet, to: outputDirectory.appendingPathComponent("contact-sheet.jpg"))
print("Rendered \(specs.count) posters as PNG + JPEG, plus contact sheets")
