PImage img;
PrintWriter output; 

float sqr(int x)
{
  
  return x * x;
}
void setup() {
  size(400,400);
  img = loadImage("img.png");

  output = createWriter("C:/Users/lacer/OneDrive/Desktop/FirstPercep/Perceptron_01/Treinamento/processingSaveData.txt");

  color c;
  float r = 0, g = 255, b = 255;
  float n = 0;
  int contp = 0;
  int contn = 0;
  float dv =0;
  int cont = 0;
  int distPar = 16;
  for(int x=0 ; x < img.width * img.height;x++){
    if(cont == 4096) break;
    int i = (int)random(img.width);
    int j = (int)random(img.height);
      c = img.get(i,j);
      r = red(c);
      g = green(c);
      b = blue(c);
       
      dv = dist(r, g, b, 0, 6,23); 
     // print(dv + "\n");
        if(dv < distPar && contn < 2048)
        {
          contn++;
          output.println(r+"\t"+g+"\t"+b+"\t-1");
        cont++;

        }
        
        if(dv >= distPar && contp < 2048)
        {
          contp++;
           output.println(r+"\t"+g+"\t"+b+"\t+1");
        cont++;

        }
      
      
    }//end-for-j

  println("contn == "+contn);
  println("contp == "+ contp);
  
  output.flush();  
  output.close();  
  exit();  
}



void draw() {
  image(img, 0, 0);
}
