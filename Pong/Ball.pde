class Ball extends GameObject { //<>//
  private PVector direction;
  private float radius;
  private float minSpeed, maxSpeed, speedInc;
  private Paddle leftPaddle, rightPaddle;
  private boolean collisionHandled;
  private int numBounces;
  private AudioSample bounceSound;

  Ball(PVector pos, float radius, Paddle leftPaddle, Paddle rightPaddle) {
    super(pos, new PVector(radius, radius));
    this.minSpeed = (height - size.y) / 2.0;
    this.maxSpeed = (height - size.y) * (3.7 / 4.0);
    this.speedInc = (height - size.y) / 10.0;
    this.speed = minSpeed;
    this.col = currentStyle.white;
    this.radius = radius;
    direction = new PVector();
    this.leftPaddle = leftPaddle;
    this.rightPaddle = rightPaddle;
    createBounceSound();
  }

  void render() {
    pushStyle();
    noStroke();
    ellipseMode(CORNER);
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
  
  void setSpeed(float speed) {
    super.setSpeed(constrain(speed, minSpeed, maxSpeed));
  }
  
  void setNumBounces(int numBounces) {
    this.numBounces = numBounces;
  }

  void adjustSpeed(float adjust) {
    setSpeed(speed + adjust);
  }

  void doInput() {
  }

  void gameTick() {
    pos.add(direction.x * speed * deltaTime, direction.y * speed * deltaTime);
    updatePaddleCollision();
    updateEdgeCollision();
  }

  private void updateEdgeCollision() {
    if (pos.y < 0.0 || (pos.y + size.y) > height) {
      if (!collisionHandled) {
        direction.y = -direction.y;
      }
      pos.y = constrain(pos.y, 0, height - size.y);
      if (bounceSound != null) {
        bounceSound.trigger();
      }
    }
  }

  // Using a rectangular collisions for a circular ball leads to inaccuracies in detection, especially at edges
  // Limiting the center of the ball to the paddle's bounds gives the ball's closest point to an edge of the paddle
  // From there, we can compare if the distance between the point and the ball is less than the ball's radius if they have collided
  private boolean collidesWithPaddle(Paddle paddle) {
    if (paddle == null) {
      return false;
    }
    PVector paddlePos = paddle.getPos();
    PVector paddleMaxs = PVector.add(paddlePos, paddle.getSize());
    PVector ballCenter = PVector.add(pos, PVector.div(size, 2.0));
    PVector limitedBallCenter = ballCenter.copy();
    limitedBallCenter.x = constrain(limitedBallCenter.x, paddlePos.x, paddleMaxs.x);
    limitedBallCenter.y = constrain(limitedBallCenter.y, paddlePos.y, paddleMaxs.y);
    final float HALF_RADIUS = radius * 0.5;

    /*pushStyle();
     stroke(255, 0, 0);
     circle(limitedBallCenter.x, limitedBallCenter.y, HALF_RADIUS);
     popStyle();*/

    return PVector.dist(ballCenter, limitedBallCenter) <= HALF_RADIUS;
  }

  private Paddle getCollidedPaddle() {
    if (leftPaddle == null || rightPaddle == null) {
      return null;
    }
    if (collidesWithPaddle(leftPaddle)) {
      return leftPaddle;
    }
    if (collidesWithPaddle(rightPaddle)) {
      return rightPaddle;
    }
    return null;
  }

  private void updatePaddleCollision() {
    Paddle collidedPaddle = getCollidedPaddle();
    if (collidedPaddle == null) {
      collisionHandled = false;
      return;
    }
    collidedPaddle.onCollide();
    if (!collisionHandled) {
      PVector paddlePos = collidedPaddle.getPos();
      PVector paddleSize = collidedPaddle.getSize();
      float nextHeight = constrain(paddleSize.y + collidedPaddle.getYAdjust(), 0.0, paddleSize.y);
      PVector ballCenter = PVector.add(pos, PVector.div(size, 2.0));
      final float MAX_DEFLECT_ANGLE = (5.0 * PI) / 12.0;
      float deflectAngle = map(ballCenter.y - paddlePos.y, 0.0, paddleSize.y, -MAX_DEFLECT_ANGLE, MAX_DEFLECT_ANGLE);
      float fixedAngle = constrain(deflectAngle, -MAX_DEFLECT_ANGLE, MAX_DEFLECT_ANGLE);
      boolean flipDirection = (pos.x - paddlePos.x) < 0.0; // Direction is flipped after creating angle so it can be constrained
      numBounces++;
      final int BOUNCE_SPEED_ADJUST_START = 5;
      int bounceSpeedAdjust = numBounces / BOUNCE_SPEED_ADJUST_START; // To speed up game, ball speeds up by number of bounces after BOUNCE_SPEED_ADJUST_START bounces
      adjustSpeed(bounceSpeedAdjust * speedInc);
      float yAdjust = collidedPaddle.getYAdjust();
      float constrainedYAdjust = yAdjust != 0.0 ? constrain(collidedPaddle.getYAdjust(), -1.5, 2.0) : 1.0;
      adjustSpeed(constrainedYAdjust * direction.y * speedInc);
      setAngle(fixedAngle);
      if (flipDirection) {
        direction.x = -direction.x;
      }
      if ((-collidedPaddle.getYAdjust() * direction.y) > 0.0) {
        direction.y = -direction.y;
      }
      playSound();
      collisionHandled = true;
    } else {
      if (collidedPaddle.getYAdjust() != 0) {
        adjustSpeed(abs(collidedPaddle.getYAdjust()) * speedInc * 0.5);
      }
      pos.add(0.5 * direction.x * speed * deltaTime, 0.5 * direction.y * speed * deltaTime);
    }
  }
  
  void createBounceSound() {
    try {
      bounceSound = minim.loadSample(soundPaths.get("bounceSound").toString());
    } catch (Exception e) {
      println("Failed loading bounce sound: ", e.toString());
    }
  }
  
  void playSound() {
    if (bounceSound != null) {
      bounceSound.trigger();
    }
  }
  
  void deleteBounceSound() {
    if (bounceSound != null) {
      bounceSound.close();
      bounceSound = null;
    }
  }
}
