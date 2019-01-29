START cmd /C checkpackadges.bat

START cmd /C matlab -r "download_updates Func_A" -nosplash -minimize -nodesktop

START cmd /C matlab -r "analysis Func_B" -nosplash -minimize -nodesktop