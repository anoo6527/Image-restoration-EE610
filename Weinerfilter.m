function Weinerfilter(input, kernel, kernelnum,ground) 
g =imread(input);
J = imread(ground);
imshow(g*1.8);
a1 = size(g);
h = imread(kernel);
if kernelnum == 1
    h = h(28:48,25:45);
    a = 15
elseif kernelnum == 2
    h = h(18:38,25:45)
    a = 22
elseif kernelnum == 3
    h = h(21:41,29:49)
    a = 15
elseif kernelnum == 4
    h = h(21:41,30:50)
    a = 12
end

H = fft2(h,a1(1),a1(2));
G_red = fft2(g(:,:,1));
G_green = fft2(g(:,:,2));
G_blue = fft2(g(:,:,3));

NSR = 1/25;

AH2 = norm(H)^2;
Fd_red=((AH2./(AH2+NSR))./H).*G_red;
Fd_green=((AH2./(AH2+NSR))./H).*G_green;
Fd_blue=((AH2./(AH2+NSR))./H).*G_blue;
Fd(:,:,1) = Fd_red;
Fd(:,:,2) = Fd_green;
Fd(:,:,3) = Fd_blue;
f = ifft2(Fd); 
%maxf = max(max(max(f))); 
f = f * a ;
figure 
imshow(f);
value = psnr(uint8(f), J)
