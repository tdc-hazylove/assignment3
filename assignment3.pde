Ball b;
void setup() {
  size(700, 700, P3D);
  colorMode(RGB);
  b = new Ball(width / 2, height / 2, 100);
}

void draw() {
  background(0);
  b.update();
  b.display();
}

class Ball {
  PVector location;
  float r, startAngle, aVelocity;
  float step , offset, noiseSeed;
  int seed;
  String [] txt;
  int colors = 230;
  Ball(float x, float y, float _r) {
    location = new PVector(x, y, -_r);
    startAngle = 0;
    aVelocity = -0.5;
    r = _r;
    txt = new String[]{"What's up?Danger","(O_o)(o_O)",};
    seed = int(random(400));
  }

  void update() {
    randomSeed(seed);
    startAngle += aVelocity;
    noiseSeed += 0.08;
  }

  PVector posByAngle(float theta1, float theta2) {
    float x = r * cos(theta2) * cos(theta1);
    float y = r * sin(theta2);
    float z = r * cos(theta2) * sin(theta1);
    return new PVector(x, y, z);
  }
  
  void setStep(float s){
    step = s;offset = s / 4;
  }

  void displayText() {
    r = 520;
    setStep(10);
    fill(0);
    textAlign(CENTER);
    float size = map(noise(noiseSeed), 0, 1, 10, 50);
    textSize(size);
    for (int i = 0; i < 360; i+=step) {
      offset *= -1;
      for (int j = -90; j < 90; j+=step) {
        float theta1 = radians(i + startAngle), theta2 = radians(j + offset);
        PVector pos = posByAngle(theta1, theta2);
        int index = int(random(txt.length));
        pushMatrix();
        translate(pos.x, pos.y, pos.z);
        rotateY(PI / 2 -theta1);
        rotateX(-theta2);
        text(txt[index], 0, 0, 0);
        popMatrix();
      }
    }
  }

  void displayStrip() {
    r = 500;
    setStep(1);
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < 360; j+=step) { 
      for (int i = 0; i <= 180; i+=step) {
        PVector pos1 = posByAngle(radians(i), radians(j + startAngle));
        PVector pos2 = posByAngle(radians(i), radians(j + startAngle + step));
        int index = floor(map(j % 90, 0, 90, 0, colors));
        fill(colors);
        vertex(pos1.x, pos1.y, pos1.z);
        vertex(pos2.x, pos2.y, pos2.z);
      }
      
    }
    endShape();
  }

  void display() {
    translate(location.x, location.y, location.z);
    displayStrip();
    displayText();
  }
}
