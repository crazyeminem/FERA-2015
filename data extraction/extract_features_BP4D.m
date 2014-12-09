clear
oldDir = chdir('../C++ models/Release');

features_exe = '"FeatureExtraction.exe"';

bp4d_loc = 'I:\datasets\FERA_2015\BP4D\BP4D\BP4D-training/';

out_loc = 'I:/datasets/FERA_2015/BP4D/processed_data/';

% Go two levels deep
bp4d_dirs = dir(bp4d_loc);
bp4d_dirs = bp4d_dirs(3:end);

for f1=1:numel(bp4d_dirs)

    if(isdir([bp4d_loc, bp4d_dirs(f1).name]))
        
        bp4d_2_dirs = dir([bp4d_loc, bp4d_dirs(f1).name]);
        bp4d_2_dirs = bp4d_2_dirs(3:end);
        
        f1_dir = bp4d_dirs(f1).name;
        
        for f2=1:numel(bp4d_2_dirs)
            f2_dir = bp4d_2_dirs(f2).name;
            if(isdir([bp4d_loc, bp4d_dirs(f1).name]))
                command = features_exe;

                curr_vid = [bp4d_loc, f1_dir, '/', f2_dir, '/'];

                name = [f1_dir '_' f2_dir];
                output_file = [out_loc name '/'];

                output_hog = [out_loc name '.hog'];
                output_params = [out_loc name '.params.txt'];
                output_aus = [out_loc name '.au.txt'];
                output_neut = [out_loc name '.neutral'];

                command = cat(2, command, [' -fx 2000 -fy 2000 -rigid -asvid -fdir "' curr_vid '" -simalign "' output_file  '" -simscale 0.7 -simsize 112']);
                command = cat(2, command, [' -hogalign "' output_hog '"']);
                command = cat(2, command, [' -oparams "' output_params '"']);
                dos(command);
            end
        end
    end
end

chdir(oldDir)