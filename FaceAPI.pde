// Monster class ver. 0.3

AvatarFace monster;
int clicks = 0;
int brows=0;
void setup() {
  size(400, 400, P2D);
  monster = new AvatarFace();
  noCursor();
}

void draw() {
  background(200);
  monster.draw(mouseX, mouseY);
}

void mousePressed()
{
  clicks = (clicks + 1) % 5; // 0...6
  switch (clicks) {
  case 1: // close left eye
    monster.change(FeatureID.LeftEye, Action.closeEye);
    monster.change(FeatureID.RightEye, Action.closeEye);
    break;
  case 2: // close right eye
    monster.change(FeatureID.LeftEye, Action.openEye);
    monster.change(FeatureID.RightEye, Action.openEye);
    break;
  case 3: // close mouth
    monster.change(FeatureID.Mouth, Action.closeMouth);
    break;
  case 4: // open mouth
    monster.change(FeatureID.Mouth, Action.openMouth);
    break;
  case 0: // rotate
    //  monster.rotate(0.1);
  }
}


void keyPressed() {
  if (key == 'e' || key == 'E') {
    monster.change(FeatureID.Face, Action.FaceLeft);
  } else if (key == 'r' || key == 'R') {
    monster.change(FeatureID.Face, Action.FaceRight);
  } else if (key == 'b' || key == 'B') {
    brows = (brows + 1) % 3; // 0...6
    switch (brows) {
    case 1: //brow
      monster.change(FeatureID.Brow, Action.brow);    
      break;
    case 2: // brow
      monster.change(FeatureID.Brow, Action.browUp);    
      break;
    case 0:
    }
  }
}
