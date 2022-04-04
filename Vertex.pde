class Vertex {
  int x;
  int y;
  int r=30;
  String id;
  ArrayList<Vertex> neighbors=new ArrayList<Vertex>();

  Vertex(int x, int y, String id) {
    this.x=x;
    this.y=y;
    this.id=id;
  }
  void paint() {
    ellipseMode(CENTER);
    stroke(0);
    noFill();
    ellipse(this.x, this.y, this.r, this.r);
    fill(0);
    text(""+this.id, this.x, this.y);
  }

  boolean isIn(int x, int y) {
    if (dist(this.x, this.y, x, y)<this.r) return true;
    return false;
  }

  void addNeighbor(Vertex neighbor) {
    this.neighbors.add(neighbor);
  }

  void printNeighbors() {
    
    print("neighbors for vertex " + this.id + " are: ");
    for (int i=0; i < this.neighbors.size(); i++) {
      print(neighbors.get(i).id + " ");
    }
    println();
  }
  
  ArrayList<Vertex> getNeighbors(){
    return this.neighbors;
  }
}
