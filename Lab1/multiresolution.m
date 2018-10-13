function[Iregistered, M] = multiresolution(Imoving, Ifixed, res_level )

res_scale = 0.5;
Imoving_res = {};
Ifixed_res = {};
Imoving_res{res_level} = Imoving;
Ifixed_res{res_level} = Ifixed;

for i=res_level-1:-1:1
    if i == res_level
        Imoving_res{i} = imresize(Imoving, res_scale);
        Ifixed_res{i} = imresize(Ifixed, res_scale);  
%         figure;
%         imshow(Imoving_res{i}, []);
%         figure;
%         imshow(Ifixed_res{i}, []);
    else
        %resize
        Imoving_res{i} = imresize(Imoving_res{i+1}, res_scale);
        Ifixed_res{i} = imresize(Ifixed_res{i+1}, res_scale);
%         figure;
%         imshow(Imoving_res{i}, []);
%         figure;
%         imshow(Ifixed_res{i}, []);
    end
    
end


for i=1:res_level
    if i==1
        [Iregistered, M, x] = affineReg2D_withx( Imoving_res{i}, Ifixed_res{i} );
        
    else
        % Account the size of image to M
%         M(1,3) = M(1,3)*2;
%         M(2,3) = M(2,3)*2;
%         
%         x(1,3) = x(1,3)*2;
%         x(2,3) = x(2,3)*2;
        
        % prealign with previous M
        for j=i:res_level
            
            Imoving_res{j} = affine_transform_2d_double(double(Imoving_res{j}),double(M),0);
        end
%         figure, 
%         subplot(2,1,1), imshow(Imoving_res{i});
%         subplot(2,1,2), imshow(Imoving_aligned);
        
        %register
        [ Iregistered , M, x] = affineReg2D_withx( Imoving_res{i}, Ifixed_res{i}, x );
        
        size(Iregistered)
    end
     
end

end