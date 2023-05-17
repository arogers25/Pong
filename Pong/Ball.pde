class Ball extends GameObject {
  private PVector direction;
  private float radius;
  private float minSpeed, maxSpeed, speedInc;
  private Paddle[] targetPaddles;
  private PVector oldPos;
  
  Ball(PVector pos, float radius, Paddle... targetPaddles) {
    super(pos, new PVector(radius, radius));
    this.minSpeed = 500.0;
    this.maxSpeed = 1000.0;
    this.speedInc = 20.0;
    this.speed = minSpeed;
    this.col = currentStyle.white;
    this.radius = radius;
    direction = new PVector();
    this.targetPaddles = targetPaddles;
    oldPos = pos.copy();
  }
  
  void render() {
    pushStyle();
    fill(col);
    circle(pos.x, pos.y, radius);
    popStyle();
  }
  
  PVector getDirection() {
    return direction;
  }
  
  void setDirection(PVector direction) {
    this.direction.set(direction.normalize(null)); // Direction is normalized to make direction X and Y between -1 and 1
  }
  
  void setAngle(float angle) {
    this.direction.set(PVector.fromAngle(angle));
  }
  
  void adjustSpeed(float adjust) {
    setSpeed(constrain(speed + adjust, minSpeed, maxSpeed));
  }
  
  void doInput() {
  }
  
  void gameTick() {
    pos.add(direction.x * speed * deltaTime, direction.y * speed * deltaTime);
    // Both collision detections evaluated individually to make sure they run
    boolean edgeReset = updateEdgeCollision();
    boolean paddleReset = updatePaddleCollision();
    if (edgeReset || paddleReset) {
      pos.set(oldPos);
    } else {
      oldPos = pos.copy();
    }
  }
  
  private boolean updateEdgeCollision() {
    if (pos.y < 0 || (pos.y + size.y) > height) {
      direction.y = -direction.y;
      return true;
    }
    return false;
  }
  
  private boolean collidesWithPaddle(Paddle paddle) {
    if (paddle == null) {
      return false;
    }
    PVector maxs = PVector.add(pos, size);
    PVector paddlePos = paddle.getPos();
    PVector paddleMaxs = PVector.add(paddlePos, paddle.getSize());
    return pos.x <= paddleMaxs.x && maxs.x >= paddlePos.x && pos.y <= paddleMaxs.y && maxs.y >= paddlePos.y;
  }
  
  private Paddle getCollidedPaddle() { // Using a for loop instead of individual if statements for collision allows for multiple custom paddles
    if (targetPaddles == null) {
      return null;
    }
    for (Paddle paddle : targetPaddles) {
      if (collidesWithPaddle(paddle)) {
        return paddle;
      }
    }
    return null;
  }
  
  private boolean updatePaddleCollision() {
    Paddle collidedPaddle = getCollidedPaddle();
    if (collidedPaddle == null) {
      return false;
    }
    PVector paddlePos = collidedPaddle.getPos();
    PVector paddleSize = collidedPaddle.getSize();
    float nextHeight = constrain(paddleSize.y + collidedPaddle.getYAdjust(), 0.0, paddleSize.y);
    PVector ballCenter = PVector.add(pos, PVector.div(size, 2.0));
    PVector paddleCenter = PVector.add(paddlePos, PVector.div(paddleSize, 2.0));
    if (collidedPaddle.getYAdjust() != 0) {
      float reflectAngle = atan2(ballCenter.x - paddleCenter.x, ballCenter.y - (paddleCenter.y + collidedPaddle.getYAdjust()));
      setAngle(HALF_PI - reflectAngle);
      //if (reflectAngle  //<>//
      if ((-collidedPaddle.getYAdjust() * direction.y) > 0) {
        direction.y = -direction.y;
      }
    } else {
      direction.x = -direction.x;
    } //<>//
    adjustSpeed(collidedPaddle.getYAdjust() * -direction.y * speedInc);
    return true;
  }
}
