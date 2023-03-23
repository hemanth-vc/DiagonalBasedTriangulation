
 ArrayList<Triangle> getDiagonalBasedTriangulation(Polygon poly){
   ArrayList<Triangle> ret = new ArrayList<Triangle>();
   
   if(poly.bdry.size() == 3)
   {
     ret.add(new Triangle(poly.bdry.get(0).p0,poly.bdry.get(1).p0,poly.bdry.get(2).p0));
     return ret;
   }
   if(poly.bdry.size() > 3 && poly.isSimple())
   {

    {
      {
   Edge diag = poly.getaDiagonal();
   int n =poly.bdry.size();
   Polygon poly1 = new Polygon();
   Polygon poly2 = new Polygon();
     int i=0;

     if(diag != null)
     {
     while(diag.p0 != poly.bdry.get(i).p0 )
     {
       i++;
       if(i==n)i=0;
     }
     while(diag.p1 != poly.bdry.get(i).p0)
     {
       poly1.addPoint(poly.bdry.get(i).p0);

       i++;
       if(i==n)i=0;
     }
  poly1.addPoint(diag.p1);

     poly2.addPoint(diag.p0);

     while(diag.p0 != poly.bdry.get(i).p0)
     {
       poly2.addPoint(poly.bdry.get(i).p0);

       i++;
       if(i==n)i=0;
     }

     
     ArrayList<Triangle> part1 = getDiagonalBasedTriangulation(poly1);
     ArrayList<Triangle> part2 = getDiagonalBasedTriangulation(poly2);
     if(part1.size()!=0)
     ret.addAll(part1);
     if(part2.size()!=0)
     ret.addAll(part2);
     }
   }
    }
   }
   return ret;
 } //<>//
