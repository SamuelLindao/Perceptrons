import java.io.File;

PImage img;
PImage imgP;
PImage imgN;

void setup() {
  size(1920, 620);

  String sourceFolder = "C:\\Users\\lacer\\OneDrive\\Desktop\\1Heads"; // Pasta de entrada (imagens originais)
  String destinationFolder = "C:\\Users\\lacer\\OneDrive\\Desktop\\2Heads"; // Pasta de saída

  File destFolder = new File(destinationFolder);
  if (!destFolder.exists()) {
    destFolder.mkdirs();
  }

  File folder = new File(sourceFolder);
  File[] files = folder.listFiles();
  if (files == null) {
    println("Nenhuma imagem encontrada na pasta: " + sourceFolder);
    exit();
  }

  float w1 = -0.1978115; 
  float w2 = 0.03838694; 
  float w3 = -0.94511974; 
  float bias = 960.2192;
  float c = 155;
  for (File file : files) {
    if (file.isFile() && (file.getName().endsWith(".png") || file.getName().endsWith(".jpg"))) {
      String name = file.getName();
      img = loadImage(sourceFolder + "/" + name);
      imgP = loadImage(sourceFolder + "/" + name);
      imgN = loadImage(sourceFolder + "/" + name);

      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          color co = img.get(i, j);
          float r = i;
          float g = j;
          float b = abs(i - img.width / 2 - c);

          float newS = (w1 * r) + (w2 * g) + (w3 * b) + bias;
          if (newS < 0) {
            imgP.set(i, j, color(255, 255, 255));
          } else {
            imgN.set(i, j, color(255, 255, 255));
          }
        }
      }

      imgP.save(destinationFolder + "/" + name.replace(".png", "_P.png"));
      //imgN.save(destinationFolder + "/" + name.replace(".png", "_N.png"));
    }
  }
  println("Processamento concluído! Imagens salvas em: " + destinationFolder);
  exit();
}
