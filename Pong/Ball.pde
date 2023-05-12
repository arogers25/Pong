class Ball extends GameObject {
  private PVector direction;
  private float radius;
  private Paddle leftPaddle, rightPaddle;
  
  Ball(PVector pos, float radius, Paddle leftPaddle, Paddle rightPaddle) {
    super(pos, new PVector(radius, radius));
    this.speed = 300.0;
    this.col = currentStyle.white;
    this.radius = radius;
    direction = new PVector();
    this.leftPaddle = leftPaddle;
    this.rightPaddle = rightPaddle;
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
  
  void doInput() {
  }
  
  void gameTick() {
    PVector oldPos = pos.copy();
    pos.add(direction.x * speed * deltaTime, direction.y * speed * deltaTime);
    boolean resetPos = updateEdgeCollision() || updatePaddleCollision();
    if (resetPos) {
      pos.set(oldPos);
    }
  }
  
  private boolean updateEdgeCollision() {
    if (pos.x <= 0 || pos.x + size.x >= width) {
      direction.x = -direction.x;
      return true;
    }
    if (pos.y <= 0 || pos.y + size.y >= height) {
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
    return pos.x < paddleMaxs.x && maxs.x > paddlePos.x && pos.y < paddleMaxs.y && maxs.y > paddlePos.y;
  }
  
  private boolean updatePaddleCollision() {
    if (!collidesWithPaddle(leftPaddle) && !collidesWithPaddle(rightPaddle)) {
      return false;
    }
    direction.x = -direction.x;
    return true;
  }
}
