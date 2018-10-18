function truncatedInv(input, kernel, kernelnum, d0,ground)
f=imread(input); % load image
h = imread(kernel);
J = imread(ground);

Ax = f*1.8;
imshow(Ax)


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


a1 = size(f);
H = fft2(h,a1(1),a1(2));
fil = zeros(a1(1), a1(2)); 
order = 2; 
% figure 
% imshow(H)

for i=1:a1(1)
    for j=1:a1(2)
        dist= ((i-a1(1)/2)^2 + (j-a1(2)/2)^2)^0.5;
        fil(i,j)= ( 1 + (dist/d0)^(2*order))^(-1);
    end
end

% figure
% imshow(filte)

H = H .* fil; 
% figure
% imshow(H)

red_image = ifft2(fft2(f(1:end,1:end,1))./H);
green_image = ifft2(fft2(f(1:end,1:end,2))./H) ;
blue_image = ifft2(fft2(f(1:end,1:end,3))./H);

output = zeros([size(f)]);
output(1:end,1:end,1) = red_image;
output(1:end,1:end,2) = green_image;
output(1:end,1:end,3) = blue_image;

A = output/250;  %15- K1; 22-K2; 
figure
imshow(A)

value = psnr(uint8(A), J)
%val = ssim(uint8(A), J)