PImage img;
PImage imgP;
PImage imgN;

void setup() {
  size(1920, 620);
  img = loadImage("img.png");
  imgP = loadImage("img.png");
  imgN = loadImage("img.png");
  color co;
  float r, g, b;
float w1 = -0.22330308; float w2 = -0.093187116; float w3 = -0.9236119;float bias = 554.58388;


  for (int i=0; i<img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      co = img.get(i, j);
      r = i;
      g = j;
      b = abs(j - (img.height/2-200));

      float newS = (w1*r) + (w2*g) + (w3 * b)  + bias;
      if (newS < 0)
      {
        imgP.set(i, j, color(255, 255, 255));
      } else
      {
        imgN.set(i, j, color(255, 255, 255));
      }
    }
  }
  imgP.save("Positive.png");
  imgN.save("Negative.png");
}
void draw()
{
  image(imgN, 0, 0, img.width/3, img.height/3);
  image(imgP, img.width/2 - (img.width/6), 0, img.width/3, img.height/3);
}
