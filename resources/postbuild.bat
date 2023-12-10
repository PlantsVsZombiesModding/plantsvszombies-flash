cd lib/ 
if exist "resources.zip" del /f "resources.zip"
ren "resources.swc" "resources.zip"
powershell -command "Expand-Archive -Force 'resources.zip' 'temp/'"
cd temp/
ren "library.swf" "resources.swf"
move "resources.swf" ../../../bin/