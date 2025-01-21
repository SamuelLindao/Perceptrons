import java.io.File;

//PrintWriter output;

PImage img;
PImage imgP;
PImage imgN;

void setup() {
  size(1920, 620);
  
  String folderPath = "C:\\Users\\lacer\\OneDrive\\Desktop\\HeadPngs";
  String exitPath = "C:\\Users\\lacer\\OneDrive\\Desktop\\1Heads";
  File folder = new File(folderPath);
  
  if (!folder.exists() || !folder.isDirectory()) {
    println("Pasta não encontrada ou inválida: " + folderPath);
    exit();
  }
  
  File[] files = folder.listFiles((dir, name) -> name.toLowerCase().endsWith(".png"));
  
  if (files == null || files.length == 0) {
    println("Nenhuma imagem PNG encontrada na pasta.");
    exit();
  }
  
  float w1 = 0.8798642, w2 = -0.14003065, w3 = -0.6399693, bias = -24.040000863;
  int id = 0;
  for (File file : files) {
    String fileName = file.getName();
    println("Processando: " + fileName);
    
    img = loadImage(folderPath + "\\" + fileName);
    imgP = loadImage(folderPath + "\\" + fileName);
    imgN = loadImage(folderPath + "\\" + fileName);
    
    //output = createWriter(exitPath + "\\Z" + fileName.replace(".png", ".txt"));

    for (int i = 0; i < img.width; i++) {
      for (int j = 0; j < img.height; j++) {
        color co = img.get(i, j);
        float r = red(co);
        float g = green(co);
        float b = blue(co);

        float newS = (w1 * r) + (w2 * g) + (w3 * b) + bias;
        if (newS > 0) {
          imgN.set(i, j, color(255, 255, 255));
           //output.println(i+"\t"+j+"\t"+id+"\t"+r+"\t"+g+"\t"+b);

        } else {
          imgP.set(i, j, color(255, 255, 255));
        }
      }
     
    }
  //   output.flush();
    //  output.close();
      id++;
    imgP.save(exitPath + "\\" + fileName.replace(".png", "_P.png"));
  }
  
  println("Processamento concluído.");
}

void draw() {
  noLoop();
}
