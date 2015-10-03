 //<>//
public class MonsterFace extends FaceGroup
{
  public MonsterFace(String id) {
    super(id);
    PShape s = createShape(ARC, 40, 0, 260, 200, PI, TWO_PI-PI/180);

    s.setFill(color(164, 198, 57));
    s.setStroke(color(0)); 
    shape.addChild(s);
  }
}


public class MonsterEye extends AnimatedFeature
{
  public MonsterEye(String id, int x, int y) {
    super(id, x, y);
    open();
  }

  public PShape open() {
    shape = createShape(ELLIPSE, x, y, 20, 20);
    shape.setFill(color(0));
    shape.setStroke(color(0));
    return super.open();
  } 

  public PShape close() {
    shape = createShape(ELLIPSE, x, y, 20, 6);
    shape.setFill(color(0));
    //shape.setStrokeWeight(4);
    //shape.setStroke(color(250,0,0));
    return super.close();
  }
}


public class MonsterMouth extends AnimatedFeature
{  
  public MonsterMouth(String id, int x, int y) {
    super(id, x, y);
    open();
  }

  public PShape open() {
    shape = createShape();
    shape.beginShape(TRIANGLE_STRIP);
    shape.fill(255);
    shape.stroke(0);
    shape.vertex(x+20, y+75);
    shape.vertex(x+30, y+60);
    shape.vertex(x+40, y+75);
    shape.vertex(x+50, y+60);
    shape.vertex(x+60, y+75);
    shape.vertex(x+70, y+60);
    shape.vertex(x+80, y+75);
    shape.endShape(CLOSE);
    return super.open();
  } 

  public PShape close() {
    shape = createShape(LINE, x+25, y+50, x+75, y+50);
    shape.setFill(color(0));
    shape.setStrokeWeight(4);
    shape.setStroke(color(250, 0, 0));
    return super.close();
  }
}


public class MonsterBrows extends AnimatedFeature {
  public MonsterBrows(String id, int x, int y) {
    super(id, x, y);
    brows();
  }
  public PShape brows() {
    shape = createShape();
    shape.beginShape();
    shape.stroke(0);
    shape.vertex(x-10, y);
    shape.bezierVertex( x-10, y, x, y-5, x+10, y);
    shape.endShape(CLOSE);  
    shape.setFill(0);    

    return super .open();
  }
  public PShape browsUp() {
    shape = createShape();
    shape.beginShape();
    shape.stroke(0);
    shape.vertex(x-10, y-10);
    shape.bezierVertex( x-10, y-10, x, y-15, x+10, y-10);
    shape.endShape(CLOSE); 
    shape.setFill(0);    

    return super.open();
  }  
  
}

public class AvatarFace
{
  MonsterEye ojoIzq;
  MonsterEye ojoDer;
  MonsterMouth boca;
  MonsterBrows cejaIzq;
  MonsterBrows cejaDer;
  MonsterFace cara;

  public AvatarFace()
  {
    ojoIzq = new MonsterEye("ojoIzq", -40, -40);
    ojoDer = new MonsterEye("ojoDer", 100, -40);
    cejaIzq = new MonsterBrows("cejaIzq", -40, -55);
    cejaDer = new MonsterBrows("cejaDer", 100, -55);
    boca = new MonsterMouth("boca", -20, -80);
    cara = new MonsterFace("puppet");  
    cara.add(ojoIzq);
    cara.add(ojoDer);
    cara.add(cejaIzq);
    cara.add(cejaDer);
    cara.add(boca);
  }

  public void draw(int x, int y) {
    cara.position(x, y);
    cara.draw();
  }

  public BasicState status(FeatureID id) {
    if (id == FeatureID.LeftEye) {
      return ojoIzq.status();
    } else if (id == FeatureID.RightEye) {
      return ojoDer.status();
    }
    return BasicState.Undefined;
  }

  public void change(FeatureID id, Action action)
  {
    // PS BUG no-enum-switch 
    if (id == FeatureID.LeftEye) { // ojo izq?
      if (action == Action.closeEye) {
        cara.replaceShape(ojoIzq.getID(), ojoIzq.close());
      } else {
        cara.replaceShape(ojoIzq.getID(), ojoIzq.open());
      }
    } else if (id == FeatureID.RightEye) { // ojo der?
      if (action == Action.closeEye) {
        cara.replaceShape(ojoDer.getID(), ojoDer.close());
      } else {
        cara.replaceShape(ojoDer.getID(), ojoDer.open());
      } // if close
    } else if (id == FeatureID.Mouth) { // boca?
      if (action == Action.closeMouth) {
        cara.replaceShape(boca.getID(), boca.close());
      } else {
        cara.replaceShape(boca.getID(), boca.open());
      } // if close
    } else if (id == FeatureID.Face) { //cara
      if (action == Action.FaceLeft) {
        cara.rotate(0.1);
      } else if (action == Action.FaceRight) {
        cara.rotate(-0.1);
      } // if close
    } else if (id == FeatureID.Brow) { //cejas
      if (action == Action.brow) {
        cara.replaceShape(cejaIzq.getID(), cejaIzq.brows());
        cara.replaceShape(cejaDer.getID(), cejaDer.brows());
      } else if (action == Action.browUp) {
        cara.replaceShape(cejaIzq.getID(), cejaIzq.browsUp());
        cara.replaceShape(cejaDer.getID(), cejaDer.browsUp());
      } // if close
    } // else
  }
   // change()
} // AvatarFace class
