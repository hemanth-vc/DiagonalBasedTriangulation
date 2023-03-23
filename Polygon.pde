

class Polygon {
  
   ArrayList<Point> p     = new ArrayList<Point>();
   ArrayList<Edge>  bdry = new ArrayList<Edge>();
     
   Polygon( ){  }
   
   
   boolean isClosed(){ return p.size()>=3; }
   
   
   boolean isSimple(){
      //<>//
     ArrayList<Edge> bdry = getBoundary();
     boolean test = false;
     int N = bdry.size();
     for(int i=0; i<N;i++ )
     {
       for(int j = i+2; j<N && !(i==0 && j==N-1);j++)
       {
          test = bdry.get(i).intersectionTest(bdry.get(j));
         if(test == true)
         {
           return false;
         }
         else continue;
       }
     }
     return true;
   }
   
   
   boolean pointInPolygon( Point p ){

     ArrayList<Edge> bdry = getBoundary();
     float maxX = bdry.get(0).p0.p.x;
     int n = bdry.size();
     for(int i=0; i< n;i++)
     {
       if(bdry.get(i).p0.p.x > maxX) maxX = bdry.get(i).p0.p.x;
     }
     Random rand =  new Random();
     float randomX = maxX + rand.nextFloat();// * (Float.MAX_VALUE - maxX);
     float randomY = rand.nextFloat();// * (Float.MAX_VALUE);
     
     Edge e = new Edge(p,new Point(randomX,randomY));
     int count =0;
     for(int i=0; i<n;i++)
     {
       if(e.intersectionTest(bdry.get(i))) count++;
     }
     if(count%2==0) return false;
     else return true;
   }

   
   Edge getaDiagonal()
    {
      boolean test = false;
      ArrayList<Edge> bdry = getBoundary();
     ArrayList<Edge> diag = getPotentialDiagonals();
     ArrayList<Edge> ret  = new ArrayList<Edge>();
    int N = bdry.size();
     int M = diag.size();
     for(int i =0; i<M ;i++)
     {
       test =false;
       for(int j=0; j<N; j++)
       {
         if(diag.get(i).p0 == bdry.get(j).p0 || diag.get(i).p0 == bdry.get(j).p1 || diag.get(i).p1 == bdry.get(j).p0 || diag.get(i).p1 == bdry.get(j).p1)
         {continue;}
         else
         {
           test = diag.get(i).intersectionTest(bdry.get(j));
         }
         if(test==true)
       {break;}
       }
       if(test==true)
       {continue;}
       else
       {
         Point testPoint =  new Point(0.5* (diag.get(i).p0.p.x+diag.get(i).p1.p.x),0.5* (diag.get(i).p0.p.y+diag.get(i).p1.p.y));
         if(pointInPolygon(testPoint)) 
         {
           return diag.get(i);
         }
       }
     }
     if(ret.size()>0)
     return ret.get(0);
     else return null;
    }
   
   ArrayList<Edge> getDiagonals(){
    boolean test = false;
     ArrayList<Edge> bdry = getBoundary();
     ArrayList<Edge> diag = getPotentialDiagonals();
     ArrayList<Edge> ret  = new ArrayList<Edge>();
     int N = bdry.size();
     int M = diag.size();
     for(int i =0; i<M ;i++)
     {
       test =false;
       for(int j=0; j<N; j++)
       {
         if(diag.get(i).p0 == bdry.get(j).p0 || diag.get(i).p0 == bdry.get(j).p1 || diag.get(i).p1 == bdry.get(j).p0 || diag.get(i).p1 == bdry.get(j).p1)
         {continue;}
         else
         {
           test = diag.get(i).intersectionTest(bdry.get(j));
         }
         if(test==true)
       {break;}
       }
       if(test==true)
       {continue;}
       else
       {
         Point testPoint =  new Point(0.5* (diag.get(i).p0.p.x+diag.get(i).p1.p.x),0.5* (diag.get(i).p0.p.y+diag.get(i).p1.p.y));
         if(pointInPolygon(testPoint)) 
         {ret.add(diag.get(i));}
       }
     }
     return ret;
   }
   

   ArrayList<Edge> getDiagonalsOptimized(){
     boolean test = false;
     ArrayList<Edge> bdry = getBoundary();
     ArrayList<Edge> diag = getPotentialDiagonals();
     ArrayList<Edge> ret  = new ArrayList<Edge>();
     int N = bdry.size();
     int M = diag.size();
     for(int i =0; i<M ;i++)
     {
       test =false;
       for(int j=0; j<N; j++)
       {
         if(diag.get(i).p0 == bdry.get(j).p0 || diag.get(i).p0 == bdry.get(j).p1 || diag.get(i).p1 == bdry.get(j).p0 || diag.get(i).p1 == bdry.get(j).p1)
         {continue;}
         else
         {
           test = diag.get(i).intersectionTest(bdry.get(j));
         }
         if(test==true)
       {break;}
       }
       if(test==true)
       {continue;}
       else
       {
         Point testPoint =  new Point(0.5* (diag.get(i).p0.p.x+diag.get(i).p1.p.x),0.5* (diag.get(i).p0.p.y+diag.get(i).p1.p.y));
         if(pointInPolygon(testPoint)) 
         {ret.add(diag.get(i));}
       }
     }
     return ret;
   }
      
   
   
   boolean ccw(){
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
     
      if(this.areaS()>0) return true;
      else return false;
   }
   
   
   boolean cw(){

     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
     
     return !this.ccw();
   }
   
   float areaS(){

     float area = 0.0;
    int n = this.p.size();
    for (int i = 0; i < n; i++) {
        int j = (i + 1) % n;
        area += this.p.get(i).p.x * this.p.get(j).p.y - this.p.get(j).p.x * this.p.get(i).p.y;//  polygon[i][0] * polygon[j][1] - polygon[j][0] * polygon[i][1];
    }
    return 0.5 * area; 
   }
   
   float area()
 {
   return Math.abs(this.areaS());
 }
      

   ArrayList<Edge> getBoundary(){
     return bdry;
   }


   ArrayList<Edge> getPotentialDiagonals(){
     ArrayList<Edge> ret = new ArrayList<Edge>();
     int N = p.size();
     for(int i = 0; i < N; i++ ){
       int M = (i==0)?(N-1):(N);
       for(int j = i+2; j < M; j++ ){
         ret.add( new Edge( p.get(i), p.get(j) ) );
       }
     }
     return ret;
   }
   

   void draw(){
     //println( bdry.size() );
     for( Edge e : bdry ){
       e.draw();
     }
   }
   
   int getEarTip()
   {
     int ret = -1;
     ArrayList<Edge> bdry = getBoundary();
     int size = bdry.size();
     boolean test = false;
     
     for(int i = 0; i< size ;i++)
     {
       if(i-1 < 0)
       {
         test = this.isDiagonal(new Edge(bdry.get(size-1).p0,bdry.get(i+1).p0));
       }
       else
       {
         if(i+1 >size-1)
       {
         test = this.isDiagonal(new Edge(bdry.get(i-1).p0,bdry.get(0).p0));
       }
       else
         test = this.isDiagonal(new Edge(bdry.get(i-1).p0,bdry.get(i+1).p0));
       }
       if(test==true)
       {
         return i;
       }
     }
     return ret;
   }
   
   boolean isDiagonal(Edge diag)
   {
      boolean test = false;
     ArrayList<Edge> bdry = getBoundary();

     int N = bdry.size();

       test =false;
       for(int j=0; j<N; j++)
       {
         if(diag.p0 == bdry.get(j).p0 || diag.p0 == bdry.get(j).p1 || diag.p1 == bdry.get(j).p0 || diag.p1 == bdry.get(j).p1)
         {continue;}
         else
         {
           test = diag.intersectionTest(bdry.get(j));
         }
         if(test==true)
       {break;}
       }
       if(test==true)
       {return false;}
       else
       {
         Point testPoint =  new Point(0.5* (diag.p0.p.x+diag.p1.p.x),0.5* (diag.p0.p.y+diag.p1.p.y));
         if(pointInPolygon(testPoint)) 
         {return true;}
       }
       return false;
   }
   
   void addPoint( Point _p ){ 
     p.add( _p );
     if( p.size() == 2 ){
       bdry.add( new Edge( p.get(0), p.get(1) ) );
       bdry.add( new Edge( p.get(1), p.get(0) ) );
     }
     if( p.size() > 2 ){
       bdry.set( bdry.size()-1, new Edge( p.get(p.size()-2), p.get(p.size()-1) ) );
       bdry.add( new Edge( p.get(p.size()-1), p.get(0) ) );
     }
   }

}
