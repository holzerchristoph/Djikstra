//https://www.youtube.com/watch?v=pVfj6mxhdMw
ArrayList<Line> lines=new ArrayList<Line>();
ArrayList<Vertex> vertexes=new ArrayList<Vertex>();
int id=1;

boolean drawingLine=false;
Vertex v1, v2;

float getCosts(Vertex v1, Vertex v2) {
  float res=-1;
  for (int i=0; i<lines.size(); i++) {
    Line line=lines.get(i);
    if ((line.v1.id == v1.id && line.v2.id == v2.id)||
      (line.v2.id == v1.id && line.v1.id == v2.id))
    {
      return line.weight;
    }
  }
  return res;
}

boolean isIn(ArrayList<Vertex> vertexes, Vertex vertex) {
  for (int i=0; i< vertexes.size(); i++) {
    if (vertexes.get(i).id == vertex.id)
      return true;
  }
  return false;
}



void shortestPath(ArrayList<Vertex> vertexes) {
  Table table=new Table(vertexes);
  ArrayList<Vertex> visited=new ArrayList<Vertex>();
  ArrayList<Vertex> unvisited=new ArrayList<Vertex>();
  Vertex currentVertex;

  // init unvisited list
  for (int i=0; i<vertexes.size(); i++) {
    unvisited.add(vertexes.get(i));
  }

  // init first element
  currentVertex=unvisited.get(0);
  table.rows[0].updateShortestPath(0);
  table.rows[0].updatePriviorVertex(null);

  //for (int current=0; current<unvisited.size(); current++) {
  // get current vertex and put current neighbor in unvisited list
  while (unvisited.size()>0) { //<>//
    
    currentVertex=table.getSmallestDistNotVisited(unvisited);//unvisited.get(0);

    // update table
    ArrayList<Vertex> neigborsFromCurrent=currentVertex.getNeighbors();
    float dist=table.getRow(currentVertex).shortestDist;
    for (int i=0; i< neigborsFromCurrent.size(); i++) {
      Vertex currentNeighbor=neigborsFromCurrent.get(i);
      if (!isIn(visited, currentNeighbor)) {

        float costCurrentNeighbor=getCosts(currentNeighbor, currentVertex);
        Row helpRow=table.getRow(currentNeighbor);
        float h = dist + costCurrentNeighbor;
        if (h<helpRow.shortestDist) {
          table.update(currentNeighbor, h, currentVertex);
        }
      }
    }

    // delete current vertex from unvisited list and put vertex in visited list
    unvisited.remove(currentVertex);
    visited.add(currentVertex);
  }

  table.print();
}

void createExample() {
  Vertex v1, v2, v3, v4, v5;
  vertexes.add(v1=new Vertex(100, 100, ""+id));
  id++;
  vertexes.add(v2=new Vertex(200, 100, ""+id));
  id++;
  vertexes.add(v3=new Vertex(250, 150, ""+id));
  id++;
  vertexes.add(v4=new Vertex(100, 200, ""+id));
  id++;
  vertexes.add(v5=new Vertex(200, 200, ""+id));
  id++;
  lines.add(new Line(v1, v2, 6));
  lines.add(new Line(v2, v3, 5));
  lines.add(new Line(v3, v5, 5));
  lines.add(new Line(v2, v5, 2));
  lines.add(new Line(v4, v5, 1));
  lines.add(new Line(v1, v4, 1));
  lines.add(new Line(v4, v2, 2));
  v1.addNeighbor(v4);
  v1.addNeighbor(v2);

  v2.addNeighbor(v1);
  v2.addNeighbor(v4);
  v2.addNeighbor(v5);
  v2.addNeighbor(v3);

  v3.addNeighbor(v2);
  v3.addNeighbor(v5);

  v5.addNeighbor(v4);
  v5.addNeighbor(v2);
  v5.addNeighbor(v3);

  v4.addNeighbor(v1);
  v4.addNeighbor(v5);
  v4.addNeighbor(v2);
}

void setup() {
  size(500, 500);
  createExample();
}

void draw() {
  background(255);
  fill(0, 255, 0);
  ellipse(0, 0, 30, 30);

  for (int i=0; i < vertexes.size(); i++) {
    vertexes.get(i).paint();
  }
  for (int i=0; i < lines.size(); i++) {
    lines.get(i).paint();
  }

  if (drawingLine) {
    line(v1.x, v1.y, mouseX, mouseY);
  }
}


void mouseClicked() {
  if (mouseButton == LEFT) {

    if (dist( 0, 0, mouseX, mouseY) < 30) {
      shortestPath(vertexes);
    } else {
      vertexes.add(new Vertex(mouseX, mouseY, ""+id));
      id++;
    }
  }
}

void mousePressed() {
  if (mouseButton == RIGHT && drawingLine == false) {
    for (int i=0; i < vertexes.size(); i++) {
      if (vertexes.get(i).isIn(mouseX, mouseY)) {
        v1=vertexes.get(i);
        drawingLine=true;
      }
    }
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT && drawingLine == true) {
    for (int i=0; i < vertexes.size(); i++) {
      if (vertexes.get(i).isIn(mouseX, mouseY)) {
        v2=vertexes.get(i);
        drawingLine=false;
        int costs=(int)random(0, 100);
        lines.add(new Line(v1, v2, costs));

        v1.addNeighbor(v2);
        v2.addNeighbor(v1);
      }
    }
    println("--------------------------");
    for (int i=0; i < vertexes.size(); i++) {
      vertexes.get(i).printNeighbors();
    }
    println("--------------------------");
  }
}
