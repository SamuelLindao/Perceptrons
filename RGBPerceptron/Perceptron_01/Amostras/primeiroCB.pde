import java.io.File;

PImage img;
PrintWriter output;
String folderPath = "C:/Users/lacer/Documents/Perceptrons/RGBPerceptron/Perceptron_01/Amostras/imagem"; // Defina o caminho da pasta aqui
int maxImages = 5; // Defina o número máximo de imagens a processar
File folder;
File[] images;

float sqr(int x) {
  return x * x;
}
  int contp = 0;
  int contn = 0;
  
void setup() {
  size(400, 400);
  folder = new File(folderPath);
  images = folder.listFiles((dir, name) -> name.toLowerCase().endsWith(".png"));
  
  if (images == null || images.length == 0) {
    println("Nenhuma imagem encontrada na pasta.");
    exit();
  }
  
  int imagesToProcess = min(images.length, maxImages);
  
  for (int imgIndex = 0; imgIndex < imagesToProcess; imgIndex++) {
    processImage(images[imgIndex]);
  }
  
  exit();
}

void processImage(File imageFile) {
  img = loadImage(imageFile.getAbsolutePath());
  if (img == null) {
    println("Erro ao carregar: " + imageFile.getName());
    return;
  }
  
  output = createWriter("C:/Users/lacer/Documents/Perceptrons/RGBPerceptron/Perceptron_01/Treinamento/" + imageFile.getName() + "_data.txt");
  
  color c;
  float r = 0, g = 255, b = 255;
  float n = 0;

  float dv = 0;
  int cont = 0;
  int distPar = 16;
  println("Processando: " + imageFile.getName());
  int totalDados = 1520000;

  while (true) {
    for (int x = 0; x < img.width * img.height; x++) {
      if (cont == totalDados) break;
      int i = (int) random(img.width);
      int j = (int) random(img.height);
      c = img.get(i, j);
      r = red(c);
      g = green(c);
      b = blue(c);

      dv = dist(r, g, b, 0, 6, 23);

      if (dv < distPar && contn < totalDados / 2) {
        contn++;
        output.println(r + "\t" + g + "\t" + b + "\t-1");
        cont++;
      }

      if (dv >= distPar && contp < totalDados / 2) {
        contp++;
        output.println(r + "\t" + g + "\t" + b + "\t+1");
        cont++;
      }
    }
    
    println("contn == " + contn);
    println("contp == " + contp);

    output.flush();
    output.close();
    break;
  }
}

void draw() {
  if (img != null) {
    image(img, 0, 0);
  }
}
