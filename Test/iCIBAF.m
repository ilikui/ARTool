

urlApi = 'http://open.iciba.com/dsapi/';



resutJson =webread(urlApi, weboptions('ContentType','json'));


[returnAudio,fs] = webread(resutJson.tts,weboptions('ContentType','audio'));



% [mp3Y,mp3Fs]=audioread(returnAudio);
%sound(returnAudio,44109)


returnImage = webread(resutJson.picture2,weboptions('ContentType','image'));







% ????

imshow(returnImage);

