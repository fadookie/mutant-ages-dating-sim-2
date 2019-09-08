/**
 * This class stores miscellaneous utility functions.
 */
class Utils
{
	clearscope static Vector2 Polar2Cartesian(double radius, double degrees) {
    // These math functions expect angle in DEGREES, not radians! :(
    double x = radius * Cos(degrees);
    double y = radius * Sin(degrees);
    return (x, y);
	}

  clearscope static double Mapd(double value, double start1, double stop1, double start2, double stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  }
}