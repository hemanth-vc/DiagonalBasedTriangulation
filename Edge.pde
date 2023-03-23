

class Edge{
  
   Point p0,p1;
      
   Edge( Point _p0, Point _p1 ){
     p0 = _p0; p1 = _p1;
   }
      
   void draw(){
     line( p0.p.x, p0.p.y, 
           p1.p.x, p1.p.y );
   }
   
   void drawDotted(){
     float steps = p0.distance(p1)/6;
     for(int i=0; i<=steps; i++) {
       float x = lerp(p0.p.x, p1.p.x, i/steps);
       float y = lerp(p0.p.y, p1.p.y, i/steps);
       //noStroke();
       ellipse(x,y,3,3);
     }
  }
   
  public String toString(){
    return "<" + p0 + "" + p1 + ">";
  }
     
  Point midpoint( ){
    return new Point( PVector.lerp( p0.p, p1.p, 0.5f ) );     
  }
  
  float crossproduct(Edge other)
  {
    float x1 = this.p1.p.x - this.p0.p.x;
    float x2 = other.p1.p.x - other.p0.p.x;
    float y1 = this.p1.p.y - this.p0.p.y;
    float y2 = other.p1.p.y - other.p0.p.y;
        return x1 * y2 - x2 * y1;
  }
     
     float crossProd(float x1, float y1, float x2, float y2) {
        return x1 * y2 - x2 * y1;
    }
    
  boolean intersectionTest( Edge other ){ 
    Point p1 = this.p0, p2 = this.p1, p3 = other.p0, p4 = other.p1;

        float det1 = crossProd(p4.p.x - p3.p.x, p4.p.y - p3.p.y, p1.p.x - p3.p.x, p1.p.y - p3.p.y);
        float det2 = crossProd(p4.p.x - p3.p.x, p4.p.y - p3.p.y, p2.p.x - p3.p.x, p2.p.y - p3.p.y);
        float det3 = crossProd(p2.p.x - p1.p.x, p2.p.y - p1.p.y, p3.p.x - p1.p.x, p3.p.y - p1.p.y);
        float det4 = crossProd(p2.p.x - p1.p.x, p2.p.y - p1.p.y, p4.p.x - p1.p.x, p4.p.y - p1.p.y);

        if (det1 >= 0 && det2 <= 0 || det1 <= 0 && det2 >= 0){if (det3 >= 0 && det4 <= 0 || det3 <= 0 && det4 >= 0) {
                return true;
            }
        }
     return false;    
  }
  
}
