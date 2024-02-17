/*
{
  "INPUTS" : [
    {
      "TYPE" : "image",
      "NAME" : "inputImage"
    }
  ],
  "CREDIT": "",
  "DESCRIPTION": "",
  "CATEGORIES" : [
    "Dissolve"
  ],
  "ISFVSN" : "2"
}
*/

void main()	{
	gl_FragColor = IMG_NORM_PIXEL(inputImage, isf_FragNormCoord.xy);
}
