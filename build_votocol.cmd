if exist dist del dist /S /F /Q
if not exist dist md dist
copy src\capa.md + src\sumario.md + src\introducao.md + src\capitulo1.md + src\capitulo2.md + src\capitulo3.md + src\capitulo4.md + src\capitulo5.md + src\capitulo6.md + src\capitulo7.md + src\conclusao.md dist\votocol.md
call md-to-pdf.cmd dist\votocol.md
set versionfull=
for /f "tokens=*" %%i in ('findstr /R "\"version\": (.*?),$" package.json') do (
  set versionfull=%%i
)
set version=%versionfull:~-7,5%
set destfile=votocol_%version%.pdf
ren dist\votocol.pdf %destfile%
