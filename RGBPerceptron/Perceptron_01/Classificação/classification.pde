PImage img;
PImage imgP;
PImage imgN;

void setup(){  
  size(1920,620);
  String name = "a_vm2269";
     img = loadImage(name + ".png");
     imgP = loadImage(name + ".png");
     imgN = loadImage(name + ".png");
     color co;
  float r, g, b;


float w1 = 0.8798642; float w2 = -0.14003065; float w3 = -0.6399693;float bias = -24.040000863;
  for(int i=0; i<img.width; i++){
    for(int j = 0; j < img.height; j++){
      co = img.get(i,j);
      r = red(co);
      g = green(co);
      b = blue(co);

      float newS = (w1*r) + (w2*g) + (w3 * b)  + bias;
      if(newS > 0)
      {
         imgP.set(i,j, color(255,255,255));
      }
      else
      {
                 imgN.set(i,j, color(255,255,255));

      }
      
    }
  }
  imgP.save(name+ "N.png");
  imgN.save(name+"P.png");
}
  void draw()
  {
    image(imgN,0,0,img.width/3,img.height/3);
    image(imgP, img.width/2 - (img.width/6),0, img.width/3, img.height/3);
  }
 
