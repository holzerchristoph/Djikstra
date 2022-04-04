class Table {
  final static float INFINITY=99999999999999.9999999;
  Row[] rows;

  Table(ArrayList<Vertex> vertexes) {
    this.rows=new Row[vertexes.size()];
    for (int i =0; i< vertexes.size(); i++) {
      this.rows[i]=new Row(vertexes.get(i), Table.INFINITY, null);
    }
  }

  Row getRow(Vertex vertex) {
    for (int i =0; i< rows.length; i++) {
      if (rows[i].vertex.id==vertex.id)
        return rows[i];
    }
    return null;
  }

  void update(Vertex vertex, float newShortDist, Vertex newPrevVertex) {
    Row r=getRow(vertex);
    if (newShortDist < r.shortestDist) {
      r.shortestDist=newShortDist;
      r.priviorVertex=newPrevVertex;
    }
  }

  boolean isIn(ArrayList<Vertex> vertexes, Vertex vertex) {
    for (int i=0; i< vertexes.size(); i++) { //<>//
      if (vertexes.get(i).id == vertex.id)
        return true;
    }
    return false;
  }

  Vertex getSmallestDistNotVisited(ArrayList<Vertex> unvisited) {
    Vertex minVertex=unvisited.get(0);
    Row minRow=getRow(minVertex);
    
    for (int i=0; i<unvisited.size();i++){
      Vertex helpVertex=unvisited.get(i);
      Row helpRow=getRow(helpVertex);
      if (helpRow.shortestDist < minRow.shortestDist){
        minVertex=helpVertex;
        minRow=helpRow;
      }
    }
   
    return minVertex;
  }

  void print() {
    for (int i =0; i< vertexes.size(); i++) {
      this.rows[i].print();
    }
  }
}

class Row {
  Vertex vertex;
  float shortestDist;
  Vertex priviorVertex;


  Row(Vertex vertex, float shortestDist, Vertex priviorVertex) {
    this.vertex=vertex;
    this.shortestDist=shortestDist;
    this.priviorVertex=priviorVertex;
  }
  void updateShortestPath(float value) {
    this.shortestDist=value;
  }
  void updatePriviorVertex(Vertex vertex) {
    this.priviorVertex=vertex;
  }
  void print() {
    if (this.priviorVertex != null)
      println(this.vertex.id + "\t" + this.shortestDist + "\t" + this.priviorVertex.id );
    else
      println(this.vertex.id + "\t" + this.shortestDist + "\tnull" );
  }
}
