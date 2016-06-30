/*:
 
 # Colors and RGB
 
*/
import UIKit

/*:
 Create an `RGB` type that is represented by 8-bit, unsigned integers for each of the red, green, and blue color channels.
 */
typealias RGB = (R: UInt8, G: UInt8, B: UInt8)

let red: RGB = (0xff, 0, 0)
let green: RGB = (0, 255, 0)
let blue: RGB = (0, 0, 255)
let cyan: RGB = (0, 255, 255)
/*:
 ## printColor
 Convert an RGB color into a UIColor. `print` here is a bit of a misnomer, but it's named this way since Xcode's Playgrounds can natively display UIColor.
 */
func printColor(c: RGB) -> UIColor
{
    // convert a 8-bit int into a CGFloat from [0,1]
    let f = { (c: UInt8) in CGFloat(c) / 255 }

    // convert an RGB to a tuple of CGFloat
    let new = (f(c.R), f(c.G), f(c.B))

    // build a UIColor from our converted color
    return UIColor(red: new.0, green: new.1, blue: new.2, alpha: 1.0)
}

printColor( (12, 5, 127))

printColor(red)
printColor(green)

/*:
 ## blend_channel
 If we want to blend two colors, we might be tempted to average each of the individual color channels. This might be fine, but a quirk in the way colors are displayed means that the intensity of a screen's pixels doesn't map linearly with a value. The equation for blending individual channels from two colors, channel1 and channel2, is given below.
 
 `sqrt( (channel1^2 + channel2^2) / 2 )`
 
 If you're interested in color and this non-linear phenomenon, look up gamma correction, and maybe start with [this Minute Physics video](https://www.youtube.com/watch?v=LKnqECcg6Gw). If you decide to test this implementation against online tools, beware that many blend naively by averaging without correcting for gamma.
 */
func blend_channel(x: UInt8, _ y: UInt8) -> UInt8
{
    let a = Double(x)
    let b = Double(y)
    let blended = sqrt((a*a + b*b) / 2.0) + 0.5
    return UInt8(blended)
}
/*:
 ## blend
 Blend all three color channels for a given RGB triplet.
 */
func blend(x: RGB, _ y: RGB) -> RGB
{
    let r = blend_channel(x.R, y.R)
    let g = blend_channel(x.G, y.G)
    let b = blend_channel(x.B, y.B)
    return (r, g, b)
}

printColor(blend(red, blue))
