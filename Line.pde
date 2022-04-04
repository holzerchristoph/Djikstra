class Line {
  Vertex v1, v2;
  float weight=0;
  Line(Vertex v1, Vertex v2, float weight) {
    this.v1=v1;
    this.v2=v2;
    this.weight=weight;
  }
  void paint() {
    stroke(0);
    line(this.v1.x, this.v1.y, this.v2.x, this.v2.y);
    
    fill(255,0,0);

    text(""+this.weight,(this.v1.x + this.v2.x)/2, (this.v1.y + this.v2.y)/2);
  }
}
