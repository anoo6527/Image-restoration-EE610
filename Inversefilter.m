
function Inversefilter(input, kernel, kernelnum, ground)
f = imread(input);
h = imread(kernel);
J = imread(ground);


%figure
%imshow(f);
if kernelnum == 1
    h = h(28:48,25:45);
    a = 15;
elseif kernelnum == 2
    h = h(18:38,25:45);
    a = 22;
elseif kernelnum == 3
    h = h(21:41,29:49);
    a = 15;
elseif kernelnum == 4
    h = h(21:41,30:50);
    a = 12;
end
h_filter = fft2(h(1:end,1:end),800,800);

r_image = a*(ifft2(fft2(f(1:end,1:end,1))./h_filter));
g_image = a*(ifft2(fft2(f(1:end,1:end,2))./h_filter));
b_image = a*(ifft2(fft2(f(1:end,1:end,3))./h_filter));

output = zeros([size(f)]);
output(:,:,1) = r_image;
output(:,:,2) = g_image;
output(:,:,3) = b_image;

%figure
%imshow(output);

value = psnr(uint8(output), J)
val = ssim(uint8(A), J)
