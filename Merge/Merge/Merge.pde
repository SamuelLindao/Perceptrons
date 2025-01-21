// Array para armazenar os nomes dos arquivos de imagem
String[] imagePaths;
int index = 0; // Índice atual

void setup() {
  size(800, 600); // Ajuste o tamanho da janela conforme necessário
  
  // Carregar os nomes dos arquivos de uma pasta
  imagePaths = listPaths("C:\\Users\\lacer\\OneDrive\\Desktop\\3Heads"); // Substitua "images" pelo nome da sua pasta
  
  if (imagePaths.length < 2) {
    println("A pasta deve conter pelo menos 2 imagens.");
    exit();
  }
  
// Verificar se ainda há imagens suficientes
  while(index < imagePaths.length)
  {
    if (index + 1 < imagePaths.length) {
    // Carregar as duas imagens consecutivas
    PImage img1 = loadImage(imagePaths[index]);
    PImage img2 = loadImage(imagePaths[index + 1]);
    PImage img3 = createImage(img1.width, img1.height, RGB);   

    print(img1 + "\t" + img2);
    for(int i =0 ; i < img1.width;i++)
    {
      for(int j = 0 ; j < img1.height;j++)
      {
         color c1 = img1.get(i,j);
         color c2 = img2.get(i,j);
         if(c1 == color(255,255,255) || c2 == color(255,255,255)) continue;
         
         if(dist(red(c1), green(c1), blue(c1),red(c2), green(c2), blue(c2)) <=16)
         {
           img3.set(i,j,color(((red(c1)+red(c2))/2),((green(c1)+green(c2))/2),((blue(c1)+blue(c2))/2)));
         }
      }
    }
    img3.save("C:\\Users\\lacer\\OneDrive\\Desktop\\Merge\\image" + index +"_" + (index + 1)+".png")
    index += 2;
  } else {
    // Reiniciar o índice se chegar ao final
    index = 0;
  }
  }
}

void draw() {
  
}

// Função para listar os arquivos de uma pasta
String[] listPaths(String folder) {
  File dir = new File(dataPath(folder));
  if (dir.isDirectory()) {
    String[] files = dir.list();
    // Filtrar apenas imagens suportadas (opcionalmente)
    return filterImages(files, folder);
  }
  return new String[0];
}

// Função para filtrar imagens suportadas
String[] filterImages(String[] files, String folder) {
  ArrayList<String> validImages = new ArrayList<String>();
  for (String file : files) {
    String ext = file.substring(file.lastIndexOf('.') + 1).toLowerCase();
    if (ext.equals("jpg") || ext.equals("png") || ext.equals("jpeg")) {
      validImages.add(folder + "/" + file);
    }
  }
  return validImages.toArray(new String[0]);
}
