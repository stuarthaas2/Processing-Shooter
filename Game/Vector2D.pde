class Vector2D
{
  //initializes x and y coordinates
  public float x, y = 0;
  
  //constructor with parameters
  public Vector2D(float x, float y){
    update(x, y);
  }
  
  //constructor without parameters
  public Vector2D() {
    update(0, 0);
  }
  
  //update x and y coordinates
  public void update(Vector2D v1) {
    this.x = v1.x;
    this.y = v1.y;
  }
  
  //update x and y coordinates
  public void update(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  //constrain x and y within a rectangular boundary
  public void constrain(Rectangle bounds) {
    x = fix((float)(Math.min(Math.max(bounds.getMinX(), x), bounds.getMaxX())), 2);
    y = fix((float)(Math.min(Math.max(bounds.getMinY(), y), bounds.getMaxY())), 2);
  }
  
  //normalize this
  public Vector2D normalize()  {
    if (getDist() != 0) {
      fix(x /= getDist(), 2);
      fix(y /= getDist(), 2);
    }
    return this;
  }
  
  //limit this
  public Vector2D limit(float max) {
    setDist(Math.min(max, getDist()));
    return this;
  }
  
  //reverse this
  public Vector2D reverse() {
    x -= x;
    y -= y;
    return this;
  }
  
  //zeroize this
  public Vector2D zero() {
    x = 0;
    y = 0;
    return this;
  }
  
  //get a clone of this
  public Vector2D clone() {
    return new Vector2D(x, y);
  }
  
  //check if this is equal to another vector
  public boolean isEqualTo(Vector2D v1) {
    return this.x == v1.x  && this.y == v1.y ? true : false;
  }
  
  //check if this is normal to another vector
  public boolean isNormalTo(Vector2D v1){
    return this.nx() == v1.nx() && this.ny() == v1.ny() ? true : false;
  }
  
  //round the coordinates to a specific amount of places
  public float fix(float value, int places){
    float temp = (float)(value * Math.pow(10, places));  
    return (float)(temp/Math.pow(10, places));
  }
  
  //get this as a string 
  public String toString(){
    return "[Vector2D (x:" + x + ", y:" + y + ")]";
  }
  
  //get the sign of this
  public int sign(Vector2D v1){
    return rn().dotProduct(v1) < 0 ? -1 : 1;
  }
  
  //get the dotProuct between this and the normal of another vector
  public float dotProduct(Vector2D v1) {
    return fix(x * v1.nx() + y * v1.ny(), 2);
  }
  
  //get the dotProduct between this and another vector
  public float dotProduct2(Vector2D v1) {
    return fix(x * v1.x + y * v1.y, 2);
  }
  
  //get the crossProduct of this and another vector
  public float crossProduct(Vector2D v1) {
    return fix((x * v1.x) - (y * v1.y), 2);
  }
  
  //get the perpProduct of this and another vector;=
  public float perpProduct(Vector2D v1) {
    float perpProduct = fix(1 / x * v1.y - y * v1.x, 2);

    if (perpProduct != 0) {
      return perpProduct;
    } else {
      return 1;
    }
  }  
  
  //get a projection of this from another vector
  public Vector2D project(Vector2D v1) {
    float dp = dotProduct(v1);

    float px = fix(dp * v1.nx(), 2);
    float py = fix(dp * v1.ny(), 2);

    return new Vector2D(px, py);
  }
  
  //get the angle between this and another vector
  public float angleBetween(Vector2D v1) {
    return fix((float)(Math.acos(dotProduct(v1) / (getDist() * v1.getDist()))), 2);
  }
  
  //add to this with another vector
  public Vector2D add(Vector2D v1) {
    x += v1.x;
    y += v1.y;
    return this;
  }
  
  //add this with a value
  public Vector2D add(float value) {
    x += value;
    y += value;
    return this;
  }
  
  //subtract from this with another vector
  public Vector2D subtract(Vector2D v1) {
    x -= v1.x;
    y -= v1.y;
    return this;
  }
  
  //subtract from this with a value
  public Vector2D subtract(float value) {
    x -= value;
    y -= value;
    return this;
  }
  
  //multiply this by another vector
  public Vector2D multiply(Vector2D v1) {
    x *= v1.x;
    y *= v1.y;
    return this;
  }
  
  //multiply this by a value
  public Vector2D multiply(float value) {
    x *= value;
    y *= value;
    return this;
  }
  
  //divide this by another vector
  public Vector2D divide(Vector2D v1) {
    x /= v1.x;
    y /= v1.y;
    return this;
  }
  
  //divide this by a value
  public Vector2D divide(float value) {
    x /= value;
    y /= value;
    return this;
  }
  
  //get the distance between this and another vector
  public float dist(Vector2D v1) {
    return fix((float)(Math.sqrt(distSq(v1))), 2);
  }
  
  //get the distance squared between this and another vector
  public float distSq(Vector2D v1) {
    float dx = v1.x - x;
    float dy = v1.y - y;
    return fix(dx * dx + dy * dy, 2);
  }
  
  //get the normal x
  public float nx() {
    if (this.getDist() != 0) {
      return fix(x / this.getDist(), 2);
    } else {
      return 0.001;
    }
  }
  
  //get the normal y
  public float ny() {
    if (this.getDist() != 0) {
      return fix(y / this.getDist(), 2);
    } else {
      return 0.001;
    }
  }
  
  //get the left normal
  public Vector2D ln() {
    return new Vector2D(y, -x);
  }
  
  //get the right normal
  public Vector2D rn() {
    return new Vector2D(-y, x);
  }
  
  //get the right normal x
  public float rx() {
    return -y;
  }
  
  //get the right normal y
  public float ry() {
    return x;
  }
  
  //get the left normal x
  public float lx() {
    return y;
  }
  
  //get the left normal y
  public float ly() {
    return -x;
  }
  
  //set the angle of this
  public void setAngle(float value) {
    float m = getDist();
    x = fix((float)(Math.cos(value) * m), 2);
    y = fix((float)(Math.sin(value) * m), 2);
  }
  
  //get the angle of this
  public float getAngle() {
    return fix((float)(Math.atan2(y, x)), 2);
  }
  
  //get the distance
  public float getDist() {
    return fix((float)(Math.sqrt(getDistSq())), 2);
  }
  
  //get the distance sq
  public float getDistSq() {
    return fix(x * x + y * y, 2);
  }
  
  //set the distance of this
  public void setDist(float value) {
    float a = getAngle();
    x = fix((float)(Math.cos(a) * value), 2);
    y = fix((float)(Math.sin(a) * value), 2);
  }
  
  //set distance and angle of this
  public Vector2D setHeading(float angle, float dist) {
    x = fix((float)(Math.cos(angle) * dist), 2);
    y = fix((float)(Math.sin(angle) * dist), 2);
    return this;
  }
}