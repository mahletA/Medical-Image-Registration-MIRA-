function[Iregistered, M] = multiresolution(Imoving, Ifixed, res_level )

res_scale = 0.5;
Imoving_res = {};
Ifixed_res = {};


for i=res_level:-1:1
    if i == res_level
        Imoving_res{i} = imresize(Imoving, res_scale);
        Ifixed_res{i} = imresize(Ifixed, res_scale);  
    else
        %resize
        Imoving_res{i} = imresize(Imoving_res{i+1}, res_scale);
        Ifixed_res{i} = imresize(Ifixed_res{i+1}, res_scale);
        %figure;
        %imshow(Imoving_res{i}, []);
    end
    
end


for i=1:res_level
    if i==1
        [Iregistered, M] = affineReg2D( Imoving_res{i}, Ifixed_res{i} );
        
    else
        % Account the size of image to M
        M(1,3) = M(1,3)*2;
        M(2,3) = M(2,3)*2;
        % prealign with previous M
        Imoving_res{i} = affine_transform_2d_double(double(Imoving_res{i}),double(M),0);
        %register
        [ Iregistered , M] = affineReg2D( Imoving_res{i}, Ifixed_res{i} );
    end
    
end

end