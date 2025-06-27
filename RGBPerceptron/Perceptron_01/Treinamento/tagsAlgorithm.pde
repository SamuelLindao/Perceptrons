import java.io.File;
import java.io.FilenameFilter;
PrintWriter output;


PImage[] imagens;
String[] listaImagens;

void setup() {
  int n = 0;
  Float x = 0.0;
  Float y = 0.0;
  Float z = 0.0;
  int c = 0;
  Float bias = 0.0;
  Float w1 = 127.0;
  Float w2 = 127.0;
  Float w3 = 127.0;
  Float s = 0.0;
  int epocas = 1500;
  int count = 0;
  String[] linhas;
  color co;

  float erro = 0;
  float entrada = 0;
  float saida = 0;
  float desejado = 0;
  float erroQuadraticoMedio = 0;



  String caminho = sketchPath("VisibleData/");
  File pasta = new File(caminho);

  if (pasta.isDirectory()) {
    File[] arquivos = pasta.listFiles(new FilenameFilter() {
      public boolean accept(File dir, String nome) {
        return nome.toLowerCase().endsWith(".jpg") ||
          nome.toLowerCase().endsWith(".png") ||
          nome.toLowerCase().endsWith(".jpeg") ||
          nome.toLowerCase().endsWith(".gif");
      }
    }
    );

    // Contar quantas imagens são múltiplos de 50
    int countMultiplo50 = 0;
    for (int i = 0; i < arquivos.length; i++) {
      if (i % 50 == 0) countMultiplo50++;
    }

    listaImagens = new String[countMultiplo50];
    imagens = new PImage[countMultiplo50];

    int idx = 0;
    for (int i = 0; i < arquivos.length; i++) {
      if (i % 50 == 0) {
        listaImagens[idx] = arquivos[i].getName();
        imagens[idx] = loadImage("VisibleData/" + listaImagens[idx]);
        println("Imagem carregada (múltiplo de 50): " + listaImagens[idx] + "_"+idx);
        idx++;
      }
    }
  } else {
    println("Pasta não encontrada.");
    exit();
  }

  output = createWriter("pesos.txt");

  for (int a =0; a < 10; a++)
  {
    println("Rodando "+a);

    linhas = loadStrings("processingSaveData.txt");
    n = linhas.length;

    float[] TAs = {0.0001f, 0.001f, 0.01f, 0.1f};
    float menorErro = Float.MAX_VALUE;
    float melhorW1 = 0, melhorW2 = 0, melhorW3 = 0, melhorBias = 0;
    float melhorTA = 0;


    for (float TA : TAs) {
      println("Testing with TA = " + TA);

      w1 = 127.0;
      w2 = 127.0;
      w3 = 127.0;
      bias = 0.0;

      int countInner = 0;
      while (countInner < epocas) {
        erroQuadraticoMedio = 0;

        for (int i = 0; i < min(linhas.length, 4096); i++) {
          String[] values = linhas[i].split("\\s+");
          x = Float.parseFloat(values[0]);
          y = Float.parseFloat(values[1]);
          z = Float.parseFloat(values[2]);
          c = int(values[3]);

          desejado = c;
          s = (w1 * x) + (w2 * y) + (w3 * z) + bias;
          saida = (s > 0) ? 1 : -1;

          erro = desejado - saida;

          if (erro != 0) {
            w1 += TA * erro * x;
            w2 += TA * erro * y;
            w3 += TA * erro * z;
            bias += TA * erro;
          }

          erroQuadraticoMedio += erro * erro;
        }

        countInner++;
      }

      erroQuadraticoMedio /= min(linhas.length, 4096);

      println("Results for TA = " + TA + ":");
      println("float w1 = " + w1 + "; float w2 = " + w2 + "; float w3 = " + w3 + ";" + " float bias = " + bias + ";");
      println("Quadratic Mean Error == " + erroQuadraticoMedio);
      println("---------------------------------------------------");

      if (erroQuadraticoMedio < menorErro) {
        menorErro = erroQuadraticoMedio;
        melhorW1 = w1;
        melhorW2 = w2;
        melhorW3 = w3;
        melhorBias = bias;
        melhorTA = TA;
      }
    }
    output.println(melhorW1 + "\t" + melhorW2+ "\t" + melhorW3);
    println("\n");
    println("======== Melhor Resultado ========");
    println("Imagem == " + a+"/"+imagens.length);
    println("TA = " + melhorTA);
    println("float w1 = " + melhorW1 + "; float w2 = " + melhorW2 + "; float w3 = " + melhorW3 + "; float bias = " + melhorBias + ";");
    println("Menor Erro Quadrático Médio: " + menorErro);
  }
  output.flush();
  output.close();
  println("Done.");
  exit();
}
