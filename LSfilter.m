
function LSfilter(input, kernel, kernelnum, gamma, ground)
g = imread(input);
h = imread(kernel);
J = imread(ground);

if kernelnum == 1
    h = h(28:48, 25:45);
    a = 15;
elseif kernelnum ==2
    h = h(18:38, 25:45);  %kernal2 
    a = 60; 
elseif kernelnum == 3
    h = h(21:41, 29:49);
    a = 15;
elseif kernelnum ==4
    h = h(21:41, 30:50);
    a= 10;
end

a1 = size(g);
H = fft2(h,a1(1),a1(2));
G = fft2(g);
G_red = fft2(g(:,:,1));
G_green = fft2(g(:,:,2));
G_blue = fft2(g(:,:,3));

H2 = norm(H)^2;
P = [0 -1 0; -1 4 -1; 0 -1 0];
P2 = norm(P)^2;

F_R=a*(((H2./(H2+(gamma*P2))))./H).*G(:,:,1);
I1(:,:,1)=(ifft2(F_R)); 
F_G=a*(((H2./(H2+(gamma*P2))))./H).*G(:,:,2);
I1(:,:,2)=(ifft2(F_G));
F_B=a*(((H2./(H2+(gamma*P2))))./H).*G(:,:,3);
I1(:,:,3)=(ifft2(F_B));

L=255.0;
M=max(max(max(I1)));
I1=(I1./M).*L;
 imshow(uint8(4*I1));

% F_hat_red = conj(H).* G_red;
% F_hat_red = F_hat_red/(AH2 + gamma* AP2);
% f_r = a*ifft2(F_hat_red);
% F_hat_green = conj(H).* G_green;
% F_hat_green = F_hat_green/(AH2 + gamma* AP2);
% f_g = a*ifft2(F_hat_green);
% F_hat_blue = conj(H).* G_blue;
% F_hat_blue = F_hat_blue/(AH2 + gamma* AP2);
% f_b = a*ifft2(F_hat_blue);
% 
% F_hat(:,:,1) = f_r;
% F_hat(:,:,2) = f_g;
% F_hat(:,:,3) = f_b;

%F_hat = F_hat/(AH2 + gamma* AP2);


% figure 
% imshow(F_hat/150)
